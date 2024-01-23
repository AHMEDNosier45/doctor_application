import 'package:dartz/dartz.dart';
import 'package:doctor_application/data/network/failure.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/repository/repository.dart';
import 'package:doctor_application/domain/useCase/base_use_case.dart';

class DoneReservationUseCase implements BaseUseCase<DoneReservationUseCaseInput, AddOrCancelOrDoneOrUpdateReservationModel>{
  final Repository _repository;

  DoneReservationUseCase(this._repository);

  @override
  Future<Either<Failure, AddOrCancelOrDoneOrUpdateReservationModel>> execute(DoneReservationUseCaseInput input) async{
    return await _repository.doneReservation(input.reservationId);
  }

}

class DoneReservationUseCaseInput {
  String reservationId;


  DoneReservationUseCaseInput(this.reservationId);
}