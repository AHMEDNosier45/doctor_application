import 'package:dartz/dartz.dart';
import 'package:doctor_application/data/network/failure.dart';
import 'package:doctor_application/data/network/requests.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/repository/repository.dart';
import 'package:doctor_application/domain/useCase/base_use_case.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, LoginOrVerificationOrAddReservationModel>{
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, LoginOrVerificationOrAddReservationModel>> execute(LoginUseCaseInput input) async{
    return await _repository.login(LoginOrResendOtpRequest(input.phoneNumber));
  }

}

class LoginUseCaseInput{
  String phoneNumber;


  LoginUseCaseInput(this.phoneNumber);
}