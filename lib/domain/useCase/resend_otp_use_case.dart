// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:doctor_application/data/network/failure.dart';
import 'package:doctor_application/data/network/requests.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/repository/repository.dart';
import 'package:doctor_application/domain/useCase/base_use_case.dart';

class ResendOtpUseCase implements BaseUseCase<ResendOtpUseCaseInput, LoginOrVerificationOrAddReservationModel>{
  final Repository _repository;

  ResendOtpUseCase(this._repository);

  @override
  Future<Either<Failure, LoginOrVerificationOrAddReservationModel>> execute(ResendOtpUseCaseInput input) async{
    return await _repository.resendOtp(LoginOrResendOtpRequest(input.phoneNumber));
  }

}

class ResendOtpUseCaseInput{
  String phoneNumber;


  ResendOtpUseCaseInput(this.phoneNumber);
}