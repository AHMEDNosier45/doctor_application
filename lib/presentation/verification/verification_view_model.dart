import 'dart:async';

import 'package:doctor_application/domain/useCase/resend_otp_use_case.dart';
import 'package:doctor_application/domain/useCase/verification_use_case.dart';
import 'package:doctor_application/presentation/base/base_view_model.dart';
import 'package:doctor_application/presentation/common/freezed_data_classes/freezed_data_classes.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';

class VerificationViewModel extends BaseViewModel
    with VerificationViewModelInputs, VerificationViewModelOutputs {
  final StreamController _phoneNumberStreamController =
  StreamController<String>.broadcast();
  final StreamController _verifyCodeStreamController =
  StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
  StreamController<void>.broadcast();
  final StreamController isVerifiedSuccessfullyStreamController =
  StreamController<bool>.broadcast();

  final VerificationUseCase _verificationUseCase;
  final ResendOtpUseCase _resendOtpUseCase;

  VerificationViewModel(this._verificationUseCase, this._resendOtpUseCase);

  VerificationObject verificationObject = VerificationObject('', '');

  @override
  void dispose() {
    super.dispose();
    _verifyCodeStreamController.close();
    _phoneNumberStreamController.close();
    _areAllInputsValidStreamController.close();
    isVerifiedSuccessfullyStreamController.close();
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
  Sink get inputVerifyCode => _verifyCodeStreamController.sink;


  @override
  verification() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));

    (await _verificationUseCase.execute(
      VerificationUseCaseInput(verificationObject.phoneNumber, verificationObject.verifyCode),
    ))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.popupErrorState,failure.message));
      },
          (data) {
        inputState.add(ContentState());
        isVerifiedSuccessfullyStreamController.add(true);
      },
    );
  }

  @override
  resend() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));

    (await _resendOtpUseCase.execute(
    ResendOtpUseCaseInput(verificationObject.phoneNumber),
    ))
        .fold(
    (failure) {
    inputState.add(ErrorState(StateRendererType.popupErrorState,failure.message));
    },
    (data) {
    inputState.add(ContentState());
    },
    );
  }

  @override
  setPhoneNumber(String phoneNumber) {
    inputPhoneNumber.add(phoneNumber);
    verificationObject = verificationObject.copyWith(phoneNumber: phoneNumber);
    inputAreAllInputsValid.add(null);
  }

  @override
  setVerifyCode(String verifyCode) {
    inputVerifyCode.add(verifyCode);
    verificationObject = verificationObject.copyWith(verifyCode: verifyCode);
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
  Stream<bool> get outputIsVerifyCodeValid =>
      _verifyCodeStreamController.stream
          .map((verifyCode) => _isVerifyCodeValid(verifyCode));


  _isPhoneNumberValid(String phoneNumber) {
    return phoneNumber.isNotEmpty;
  }

  _isVerifyCodeValid(String verifyCode) {
    return verifyCode.isNotEmpty;
  }


  _areAllInputsValid() {
    return _isPhoneNumberValid(verificationObject.phoneNumber) &&
        _isVerifyCodeValid(verificationObject.verifyCode);
  }

}

mixin class VerificationViewModelInputs {
  setPhoneNumber(String phoneNumber) {
    // TODO: implement setPhoneNumber
    throw UnimplementedError();
  }
  setVerifyCode(String verifyCode) {
    // TODO: implement setVerifyCode
    throw UnimplementedError();
  }
  verification() {
    // TODO: implement verification
    throw UnimplementedError();
  }
  resend() {
    // TODO: implement resend
    throw UnimplementedError();
  }

  Sink get inputPhoneNumber {
    // TODO: implement inputPhoneNumber
    throw UnimplementedError();
  }
  Sink get inputVerifyCode {
    // TODO: implement inputVerifyCode
    throw UnimplementedError();
  }
  Sink get inputAreAllInputsValid {
    // TODO: implement inputAreAllInputsValid
    throw UnimplementedError();
  }
}

mixin class VerificationViewModelOutputs {
  Stream<bool> get outputIsPhoneNumberValid {
    // TODO: implement outputIsPhoneNumberValid
    throw UnimplementedError();
  }
  Stream<bool> get outputIsVerifyCodeValid {
    // TODO: implement outputIsVerifyCodeValid
    throw UnimplementedError();
  }
  Stream<bool> get outputAreAllInputsValid {
    // TODO: implement outputAreAllInputsValid
    throw UnimplementedError();
  }
}
