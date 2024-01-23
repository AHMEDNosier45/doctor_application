import 'package:rxdart/rxdart.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/useCase/get_doctor_use_case.dart';
import 'package:doctor_application/domain/useCase/update_reservation_use_case.dart';
import 'package:doctor_application/presentation/base/base_view_model.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';


class RescheduleReservationViewModel extends BaseViewModel with ReservationsViewModelInputs, ReservationsViewModelOutputs {
  final BehaviorSubject _doctorDetailsStreamController = BehaviorSubject<DoctorDetailsModel>();
  final BehaviorSubject _isPickedDateStreamController = BehaviorSubject<bool>();
  final BehaviorSubject isRescheduledStreamController = BehaviorSubject<bool>();
  final UpdateReservationUseCase _updateReservationUseCase;
  final GetDoctorUseCase _getDoctorUseCase;
  String doctorId = '';
  DateTime selectedDate = DateTime.now();

  RescheduleReservationViewModel(this._updateReservationUseCase, this._getDoctorUseCase);

  @override
  void start() {
    getDoctorDetailsData();
  }

  @override
  void dispose() {
    super.dispose();
    _doctorDetailsStreamController.close();
    _isPickedDateStreamController.close();
    isRescheduledStreamController.close();
  }

  @override
  Sink get inputDoctorDetails => _doctorDetailsStreamController.sink;

  @override
  Sink get inputIsPickedDate => _isPickedDateStreamController.sink;

  getDoctorDetailsData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _getDoctorUseCase.execute(GetDoctorUseCaseInputs(doctorId)))
        .fold((failure) {
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (data) {
      if(!_doctorDetailsStreamController.isClosed) {
        inputDoctorDetails.add(data.doctorDetails);
      }

      if(!stateStreamController.isClosed) {
        inputState.add(ContentState());
      }
    });
  }

  @override
  pickDate(DateTime date) async {
    selectedDate = date;
    inputIsPickedDate.add(true);
  }

  @override
  updateReservation(String reservationId,String scheduleId,String dateTime) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.popupLoadingState));
    (await _updateReservationUseCase.execute(UpdateReservationUseCaseInput(reservationId,scheduleId,dateTime))).fold((failure) {
      inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (data) async {
      isRescheduledStreamController.add(true);
      if(!stateStreamController.isClosed) {
        inputState.add(ContentState());
      }
    });
  }

  @override
  Stream<DoctorDetailsModel> get outputDoctorDetails => _doctorDetailsStreamController.stream
      .map((doctorDetails) => doctorDetails);

  @override
  Stream<bool> get outputIsPickedDate => _isPickedDateStreamController.stream
      .map((isPickedDate) => isPickedDate);
}

mixin class ReservationsViewModelInputs{
  pickDate(DateTime date) {
    // TODO: implement pickDate
    throw UnimplementedError();
  }
  updateReservation(String reservationId,String scheduleId,String dateTime) {
    // TODO: implement updateReservation
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

mixin class ReservationsViewModelOutputs{
  Stream<DoctorDetailsModel> get outputDoctorDetails {
    // TODO: implement outputDoctorDetails
    throw UnimplementedError();
  }
  Stream<bool> get outputIsPickedDate {
    // TODO: implement outputIsPickedDate
    throw UnimplementedError();
  }
}

class ReservationsViewObject {


  ReservationsViewObject();
}