
import 'package:dartz/dartz.dart';
import 'package:doctor_application/data/network/failure.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/repository/repository.dart';
import 'package:doctor_application/domain/useCase/base_use_case.dart';

class GetDoneReservationsUseCase implements BaseUseCase<GetDoneReservationsUseCaseInputs,ActiveOrDoneOrCanceledReservationsModel> {
  final Repository _repository;

  GetDoneReservationsUseCase(this._repository);

  @override
  Future<Either<Failure, ActiveOrDoneOrCanceledReservationsModel>> execute(GetDoneReservationsUseCaseInputs input) async {
    return await _repository.getDoneReservations(input.patientId);
  }

}

class GetDoneReservationsUseCaseInputs{
  String patientId;

  GetDoneReservationsUseCaseInputs(this.patientId);
}