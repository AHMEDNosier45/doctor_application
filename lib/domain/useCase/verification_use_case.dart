// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:doctor_application/data/network/failure.dart';
import 'package:doctor_application/data/network/requests.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/repository/repository.dart';
import 'package:doctor_application/domain/useCase/base_use_case.dart';

class VerificationUseCase implements BaseUseCase<VerificationUseCaseInput, LoginOrVerificationOrAddReservationModel>{
  final Repository _repository;

  VerificationUseCase(this._repository);

  @override
  Future<Either<Failure, LoginOrVerificationOrAddReservationModel>> execute(VerificationUseCaseInput input) async{
    return await _repository.verification(VerificationRequest(input.phoneNumber,input.verifyCode));
  }

}

class VerificationUseCaseInput{
  String phoneNumber;
  String verifyCode;


  VerificationUseCaseInput(this.phoneNumber,this.verifyCode);
}