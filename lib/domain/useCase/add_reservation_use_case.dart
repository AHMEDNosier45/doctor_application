import 'package:dartz/dartz.dart';
import 'package:doctor_application/data/network/failure.dart';
import 'package:doctor_application/data/network/requests.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/repository/repository.dart';
import 'package:doctor_application/domain/useCase/base_use_case.dart';

class AddReservationUseCase implements BaseUseCase<AddReservationUseCaseInput, AddOrCancelOrDoneOrUpdateReservationModel>{
  final Repository _repository;

  AddReservationUseCase(this._repository);

  @override
  Future<Either<Failure, AddOrCancelOrDoneOrUpdateReservationModel>> execute(AddReservationUseCaseInput input) async{
    return await _repository.addReservation(AddReservationRequest(input.patientId,input.doctorId,input.scheduleId,input.dateTime));
  }

}

class AddReservationUseCaseInput {
  String patientId;
  String doctorId;
  String scheduleId;
  String dateTime;

  AddReservationUseCaseInput(this.patientId, this.doctorId, this.scheduleId,this.dateTime);
}