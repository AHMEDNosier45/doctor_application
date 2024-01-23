import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/useCase/get_doctors_use_case.dart';
import 'package:doctor_application/presentation/base/base_view_model.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';

class SpecializationDetailsViewModel extends BaseViewModel
    with
        SpecializationDetailsViewModelInput,
        SpecializationDetailsViewModelOutput {
  final BehaviorSubject _homeDataStreamController =
      BehaviorSubject<SpecializationDetailsViewObject>();
  final GetDoctorsUseCase _getDoctorsUseCase;
  String departmentId = '';

  SpecializationDetailsViewModel(this._getDoctorsUseCase);

  @override
  void start() {
    getSpecializationDetailsData();
  }

  @override
  void dispose() {
    super.dispose();
    _homeDataStreamController.close();
  }

  //input

  @override
  Sink get inputSpecializationDetailsData => _homeDataStreamController.sink;

  getSpecializationDetailsData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _getDoctorsUseCase.execute(GetDoctorsUseCaseInputs(departmentId)))
        .fold((failure) {
      inputState.add(
          ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (data) {
      if(!stateStreamController.isClosed) {
        inputState.add(ContentState());
      }

      if(!_homeDataStreamController.isClosed) {
        inputSpecializationDetailsData
            .add(SpecializationDetailsViewObject(data.doctors ?? []));
      }
    });
  }

  //output

  @override
  Stream<SpecializationDetailsViewObject> get outputSpecializationDetailsData =>
      _homeDataStreamController.stream
          .map((specializationDetailsData) => specializationDetailsData);
}

 mixin class SpecializationDetailsViewModelInput {
   Sink get inputSpecializationDetailsData {
     // TODO: implement inputSpecializationDetailsData
     throw UnimplementedError();
   }
}

 mixin class SpecializationDetailsViewModelOutput {
  Stream<SpecializationDetailsViewObject> get outputSpecializationDetailsData {
    // TODO: implement outputSpecializationDetailsData
    throw UnimplementedError();
  }
}

class SpecializationDetailsViewObject {
  List<DoctorModel> doctors;

  SpecializationDetailsViewObject(this.doctors);
}
