// ignore_for_file: void_checks

import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/useCase/get_profile_use_case.dart';
import 'package:doctor_application/presentation/base/base_view_model.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';

class ProfileViewModel extends BaseViewModel
    with ProfileViewModelInput, ProfileViewModelOutput {
  final _profileDataStreamController = BehaviorSubject<ProfileModel>();
  final GetProfileUseCase _getProfileUseCase;
  String patientId = '';

  ProfileViewModel(this._getProfileUseCase);

  @override
  void start() {
    getProfileData();
  }

  @override
  void dispose() {
    super.dispose();
    _profileDataStreamController.close();
  }

  //input

  @override
  Sink get inputProfileData => _profileDataStreamController.sink;

  getProfileData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _getProfileUseCase.execute(GetProfileUseCaseInputs(patientId))).fold((failure) {
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (data) {

      if(!_profileDataStreamController.isClosed) {
        inputProfileData.add(data);
      }

      if(!stateStreamController.isClosed) {
        inputState.add(ContentState());
      }
    });
  }

  //output

  @override
  Stream<ProfileModel> get outputProfileData =>
      _profileDataStreamController.stream.map((homeData) => homeData);
}

mixin class ProfileViewModelInput {
  Sink get inputProfileData {
    // TODO: implement inputProfileData
    throw UnimplementedError();
  }
}

mixin class ProfileViewModelOutput {
  Stream<ProfileModel> get outputProfileData {
    // TODO: implement outputProfileData
    throw UnimplementedError();
  }
}
