import 'package:dartz/dartz.dart';
import 'package:doctor_application/data/network/failure.dart';
import 'package:doctor_application/data/network/requests.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/repository/repository.dart';
import 'package:doctor_application/domain/useCase/base_use_case.dart';

class UpdateReservationUseCase implements BaseUseCase<UpdateReservationUseCaseInput, AddOrCancelOrDoneOrUpdateReservationModel>{
  final Repository _repository;

  UpdateReservationUseCase(this._repository);

  @override
  Future<Either<Failure, AddOrCancelOrDoneOrUpdateReservationModel>> execute(UpdateReservationUseCaseInput input) async{
    return await _repository.updateReservation(UpdateReservationRequest(input.reservationId,input.scheduleId,input.dateTime));
  }

}

class UpdateReservationUseCaseInput {
  String reservationId;
  String scheduleId;
  String dateTime;

  UpdateReservationUseCaseInput(this.reservationId, this.scheduleId,this.dateTime);
}