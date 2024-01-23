import 'package:dartz/dartz.dart';
import 'package:doctor_application/data/network/failure.dart';
import 'package:doctor_application/data/network/requests.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/repository/repository.dart';
import 'package:doctor_application/domain/useCase/base_use_case.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput,RegisterModel> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, RegisterModel>> execute(RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(input.name, input.phoneNumber, input.dateOfBirth));
  }

}

class RegisterUseCaseInput{
  String name;
  String phoneNumber;
  String dateOfBirth;


  RegisterUseCaseInput(this.name,this.phoneNumber,this.dateOfBirth);
}