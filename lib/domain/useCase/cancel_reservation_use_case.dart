import 'package:dartz/dartz.dart';
import 'package:doctor_application/data/network/failure.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/repository/repository.dart';
import 'package:doctor_application/domain/useCase/base_use_case.dart';

class CancelReservationUseCase implements BaseUseCase<CancelReservationUseCaseInput, AddOrCancelOrDoneOrUpdateReservationModel>{
  final Repository _repository;

  CancelReservationUseCase(this._repository);

  @override
  Future<Either<Failure, AddOrCancelOrDoneOrUpdateReservationModel>> execute(CancelReservationUseCaseInput input) async{
    return await _repository.cancelReservation(input.reservationId);
  }

}

class CancelReservationUseCaseInput {
  String reservationId;


  CancelReservationUseCaseInput(this.reservationId);
}