
import 'package:dartz/dartz.dart';
import 'package:doctor_application/data/network/failure.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/repository/repository.dart';
import 'package:doctor_application/domain/useCase/base_use_case.dart';

class GetCancelledReservationsUseCase implements BaseUseCase<GetCancelledReservationsUseCaseInputs,ActiveOrDoneOrCanceledReservationsModel> {
  final Repository _repository;

  GetCancelledReservationsUseCase(this._repository);

  @override
  Future<Either<Failure, ActiveOrDoneOrCanceledReservationsModel>> execute(GetCancelledReservationsUseCaseInputs input) async {
    return await _repository.getCancelledReservations(input.patientId);
  }

}

class GetCancelledReservationsUseCaseInputs{
  String patientId;

  GetCancelledReservationsUseCaseInputs(this.patientId);
}