import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:doctor_application/data/network/failure.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/repository/repository.dart';
import 'package:doctor_application/domain/useCase/base_use_case.dart';

class GetDepartmentsUseCase implements BaseUseCase<Void,DepartmentsModel> {
  final Repository _repository;

  GetDepartmentsUseCase(this._repository);

  @override
  Future<Either<Failure, DepartmentsModel>> execute(void input) async {
    return await _repository.getDepartments();
  }

}