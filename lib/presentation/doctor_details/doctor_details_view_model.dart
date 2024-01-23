import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/useCase/add_reservation_use_case.dart';
import 'package:doctor_application/domain/useCase/get_doctor_use_case.dart';
import 'package:doctor_application/presentation/base/base_view_model.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorDetailsViewModel extends BaseViewModel
    with DoctorDetailsViewModelInputs, DoctorDetailsViewModelOutputs {
  final BehaviorSubject _doctorDetailsStreamController = BehaviorSubject<DoctorDetailsModel>();
  final BehaviorSubject _isPickedDateStreamController = BehaviorSubject<bool>();
  final BehaviorSubject isBookedStreamController = BehaviorSubject<bool>();
  final GetDoctorUseCase _getDoctorUseCase;
  final AddReservationUseCase _addReservationUseCase;
  String doctorId = '';
  DateTime selectedDate = DateTime.now();

  DoctorDetailsViewModel(this._getDoctorUseCase, this._addReservationUseCase);

  @override
  void dispose() {
    super.dispose();
    _doctorDetailsStreamController.close();
    _isPickedDateStreamController.close();
    isBookedStreamController.close();
  }

  @override
  void start() {
    getDoctorDetailsData();
  }

  getDoctorDetailsData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _getDoctorUseCase.execute(GetDoctorUseCaseInputs(doctorId)))
        .fold((failure) {
          inputState.add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (data) {
      if(!stateStreamController.isClosed) {
        inputState.add(ContentState());
      }
      if(!_doctorDetailsStreamController.isClosed) {
        inputDoctorDetails.add(data.doctorDetails);
      }
    });
  }

  @override
  Sink get inputDoctorDetails => _doctorDetailsStreamController.sink;
  @override
  Sink get inputIsPickedDate => _isPickedDateStreamController.sink;

  @override
  pickDate(DateTime date) async {
    selectedDate = date;
    inputIsPickedDate.add(true);
  }

  @override
  mailTo() async {
    final Uri mailUrl = Uri.parse('mailto:hsyn87857@gmail.com');

    try {
      await launchUrl(mailUrl);
    } catch (error) {
      inputState.add(ErrorState(StateRendererType.popupErrorState,
          'Error occurred, couldn\'t open link'));
    }
  }

  @override
  openWhatsAppChat(String phoneNumber) async {
    //for ios
    // final String whatsappURL_ios ="https://wa.me/$phoneNumber?text=${Uri.parse("hello")}";

    final Uri whatsUrl = Uri.parse('whatsapp://send?phone=+2$phoneNumber');
    try {
      await launchUrl(whatsUrl);
    } catch (error) {
      inputState.add(ErrorState(StateRendererType.popupErrorState,
          "Unable to open whatsapp or it's not installed"));
    }
  }

  @override
  addReservation(String patientId, String doctorId, String scheduleId,String dateTime) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.popupLoadingState));
    (await _addReservationUseCase.execute(AddReservationUseCaseInput(patientId,doctorId,scheduleId,dateTime)))
        .fold((failure) {
    inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (data) {
    inputState.add(SuccessState(StateRendererType.popupSuccessState, AppStrings.successReservation));
    });
  }

  @override
  Stream<DoctorDetailsModel> get outputDoctorDetails => _doctorDetailsStreamController.stream
      .map((doctorDetails) => doctorDetails);

  @override
  Stream<bool> get outputIsPickedDate => _isPickedDateStreamController.stream
      .map((isPickedDate) => isPickedDate);

}

mixin class DoctorDetailsViewModelInputs {
  pickDate(DateTime date) {
    // TODO: implement pickDate
    throw UnimplementedError();
  }
  openWhatsAppChat(String phoneNumber) {
    // TODO: implement openWhatsAppChat
    throw UnimplementedError();
  }
  mailTo() {
    // TODO: implement mailTo
    throw UnimplementedError();
  }
  addReservation(String patientId,String doctorId,String scheduleId,String dateTime) {
    // TODO: implement addReservation
    throw UnimplementedError();
  }

  Sink get inputDoctorDetails {
    // TODO: implement inputDoctorDetails
    throw UnimplementedError();
  }
  Sink get inputIsPickedDate {
    // TODO: implement inputIsPickedDate
    throw UnimplementedError();
  }
}

mixin class DoctorDetailsViewModelOutputs {
  Stream<DoctorDetailsModel> get outputDoctorDetails {
    // TODO: implement outputDoctorDetails
    throw UnimplementedError();
  }
  Stream<bool> get outputIsPickedDate {
    // TODO: implement outputIsPickedDate
    throw UnimplementedError();
  }
}
