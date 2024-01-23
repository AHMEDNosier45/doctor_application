import 'dart:async';

import 'package:doctor_application/domain/useCase/login_use_case.dart';
import 'package:doctor_application/presentation/base/base_view_model.dart';
import 'package:doctor_application/presentation/common/freezed_data_classes/freezed_data_classes.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _phoneNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  final StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>.broadcast();
  String doctorId = '';

  LoginObject loginObject = LoginObject('');

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    super.dispose();
    _phoneNumberStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  //inPuts

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  Sink get inputPhoneNumber => _phoneNumberStreamController.sink;

  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));

    (await _loginUseCase.execute(
      LoginUseCaseInput(loginObject.phoneNumber),
    ))
        .fold(
      (failure) {
        inputState.add(
            ErrorState(StateRendererType.popupErrorState, failure.message));
      },
      (data) {
        doctorId = data.id;
        inputState.add(ContentState());
        isUserLoggedInSuccessfullyStreamController.add(true);
      },
    );
  }

  @override
  setPhoneNumber(String phoneNumber) {
    inputPhoneNumber.add(phoneNumber);
    loginObject = loginObject.copyWith(phoneNumber: phoneNumber);
    inputAreAllInputsValid.add(null);
  }

  //outPuts

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  @override
  Stream<bool> get outputIsPhoneNumberValid =>
      _phoneNumberStreamController.stream
          .map((phoneNumber) => _isPhoneNumberValid(phoneNumber));

  _isPhoneNumberValid(String phoneNumber) {
    return phoneNumber.isNotEmpty;
  }

  _areAllInputsValid() {
    return _isPhoneNumberValid(loginObject.phoneNumber);
  }
}

mixin class LoginViewModelInputs {
  setPhoneNumber(String phoneNumber) {
    // TODO: implement setPhoneNumber
    throw UnimplementedError();
  }
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  Sink get inputPhoneNumber {
    // TODO: implement inputPhoneNumber
    throw UnimplementedError();
  }
  Sink get inputAreAllInputsValid {
    // TODO: implement inputAreAllInputsValid
    throw UnimplementedError();
  }
}

mixin class LoginViewModelOutputs {
  Stream<bool> get outputIsPhoneNumberValid {
    // TODO: implement outputIsPhoneNumberValid
    throw UnimplementedError();
  }
  Stream<bool> get outputAreAllInputsValid {
    // TODO: implement outputAreAllInputsValid
    throw UnimplementedError();
  }
}
