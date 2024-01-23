// ignore_for_file: depend_on_referenced_packages

import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String phoneNumber) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(String name, String phoneNumber, String dateOfBirth) = _RegisterObject;
}

@freezed
class VerificationObject with _$VerificationObject {
  factory VerificationObject(String phoneNumber, String verifyCode) = _VerificationObject;
}
