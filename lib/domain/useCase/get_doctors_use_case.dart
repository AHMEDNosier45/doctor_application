
import 'package:dartz/dartz.dart';
import 'package:doctor_application/data/network/failure.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/repository/repository.dart';
import 'package:doctor_application/domain/useCase/base_use_case.dart';

class GetDoctorsUseCase implements BaseUseCase<GetDoctorsUseCaseInputs,DoctorsModel> {
  final Repository _repository;

  GetDoctorsUseCase(this._repository);

  @override
  Future<Either<Failure, DoctorsModel>> execute(GetDoctorsUseCaseInputs input) async {
    return await _repository.getDoctors(input.departmentId);
  }

}

class GetDoctorsUseCaseInputs{
  String departmentId;

  GetDoctorsUseCaseInputs(this.departmentId);
}