// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:doctor_application/data/network/failure.dart';

abstract class BaseUseCase<In,Out>{
  Future<Either<Failure,Out>> execute(In input);
}