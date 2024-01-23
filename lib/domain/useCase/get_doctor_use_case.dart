
import 'package:dartz/dartz.dart';
import 'package:doctor_application/data/network/failure.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/repository/repository.dart';
import 'package:doctor_application/domain/useCase/base_use_case.dart';

class GetDoctorUseCase implements BaseUseCase<GetDoctorUseCaseInputs,DoctorAllDataModel> {
  final Repository _repository;

  GetDoctorUseCase(this._repository);

  @override
  Future<Either<Failure, DoctorAllDataModel>> execute(GetDoctorUseCaseInputs input) async {
    return await _repository.getDoctor(input.doctorId);
  }

}

class GetDoctorUseCaseInputs{
  String doctorId;

  GetDoctorUseCaseInputs(this.doctorId);
}