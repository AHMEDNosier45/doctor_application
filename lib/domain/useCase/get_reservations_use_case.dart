
import 'package:dartz/dartz.dart';
import 'package:doctor_application/data/network/failure.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/repository/repository.dart';
import 'package:doctor_application/domain/useCase/base_use_case.dart';

class GetActiveReservationsUseCase implements BaseUseCase<GetActiveReservationsUseCaseInputs,ActiveOrDoneOrCanceledReservationsModel> {
  final Repository _repository;

  GetActiveReservationsUseCase(this._repository);

  @override
  Future<Either<Failure, ActiveOrDoneOrCanceledReservationsModel>> execute(GetActiveReservationsUseCaseInputs input) async {
    return await _repository.getActiveReservations(input.patientId);
  }

}

class GetActiveReservationsUseCaseInputs{
  String patientId;

  GetActiveReservationsUseCaseInputs(this.patientId);
}