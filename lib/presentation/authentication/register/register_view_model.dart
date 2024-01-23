import 'dart:async';

import 'package:doctor_application/app/extensions.dart';
import 'package:doctor_application/domain/useCase/register_use_case.dart';
import 'package:doctor_application/presentation/base/base_view_model.dart';
import 'package:doctor_application/presentation/common/freezed_data_classes/freezed_data_classes.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final StreamController _nameStreamController =
      StreamController<String>.broadcast();
  final StreamController _phoneNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController _dateOfBirthStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  final StreamController isRegisteredSuccessfullyStreamController =
      StreamController<bool>.broadcast();

  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  RegisterObject registerObject = RegisterObject('', '', '');

  @override
  void dispose() {
    super.dispose();
    _nameStreamController.close();
    _dateOfBirthStreamController.close();
    _phoneNumberStreamController.close();
    _areAllInputsValidStreamController.close();
    isRegisteredSuccessfullyStreamController.close();
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
  Sink get inputDateOfBirth => _dateOfBirthStreamController.sink;

  @override
  Sink get inputName => _nameStreamController.sink;


  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));

    (await _registerUseCase.execute(
      RegisterUseCaseInput(registerObject.name,
          registerObject.phoneNumber, registerObject.dateOfBirth),
    ))
        .fold(
          (failure) {
        inputState.add(
            ErrorState(StateRendererType.popupErrorState, failure.message));
      },
          (data) {
        inputState.add(ContentState());
        isRegisteredSuccessfullyStreamController.add(true);
      },
    );
  }

  @override
  setPhoneNumber(String phoneNumber) {
    inputPhoneNumber.add(phoneNumber);
    registerObject = registerObject.copyWith(phoneNumber: phoneNumber);
    inputAreAllInputsValid.add(null);
  }

  @override
  setDateOfBirth(String dateOfBirth) {
    inputDateOfBirth.add(dateOfBirth);
    registerObject = registerObject.copyWith(dateOfBirth: dateOfBirth);
    inputAreAllInputsValid.add(null);
  }

  @override
  setName(String name) {
    inputName.add(name);
    registerObject = registerObject.copyWith(name: name);
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

  @override
  Stream<bool> get outputIsDateOfBirthValid =>
      _dateOfBirthStreamController.stream
          .map((dateOfBirth) => _isDateOfBirthValid(dateOfBirth));

  @override
  Stream<bool> get outputIsNameValid =>
      _nameStreamController.stream.map((name) => _isNameValid(name));


  _isPhoneNumberValid(String phoneNumber) {
    return phoneNumber.isNotEmpty;
  }

  _isDateOfBirthValid(String dateOfBirth) {
    return dateOfBirth.isNotEmpty;
  }

  _isNameValid(String name) {
    return name.isNotEmpty;
  }

  _areAllInputsValid() {
    return _isPhoneNumberValid(registerObject.phoneNumber) &&
        _isDateOfBirthValid(registerObject.dateOfBirth.orEmpty()) &&
        _isNameValid(registerObject.name);
  }
}

mixin class RegisterViewModelInputs {
  setName(String name) {
    // TODO: implement setName
    throw UnimplementedError();
  }
  setPhoneNumber(String phoneNumber) {
    // TODO: implement setPhoneNumber
    throw UnimplementedError();
  }
  setDateOfBirth(String dateOfBirth) {
    // TODO: implement setDateOfBirth
    throw UnimplementedError();
  }
  register() {
    // TODO: implement register
    throw UnimplementedError();
  }


  Sink get inputName {
    // TODO: implement inputName
    throw UnimplementedError();
  }
  Sink get inputPhoneNumber {
    // TODO: implement inputPhoneNumber
    throw UnimplementedError();
  }
  Sink get inputDateOfBirth {
    // TODO: implement inputDateOfBirth
    throw UnimplementedError();
  }
  Sink get inputAreAllInputsValid {
    // TODO: implement inputAreAllInputsValid
    throw UnimplementedError();
  }
}

mixin class RegisterViewModelOutputs {
  Stream<bool> get outputIsNameValid {
    // TODO: implement outputIsNameValid
    throw UnimplementedError();
  }
  Stream<bool> get outputIsPhoneNumberValid {
    // TODO: implement outputIsPhoneNumberValid
    throw UnimplementedError();
  }
  Stream<bool> get outputIsDateOfBirthValid {
    // TODO: implement outputIsDateOfBirthValid
    throw UnimplementedError();
  }
  Stream<bool> get outputAreAllInputsValid {
    // TODO: implement outputAreAllInputsValid
    throw UnimplementedError();
  }
}
