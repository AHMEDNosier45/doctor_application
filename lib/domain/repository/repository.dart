import 'package:dartz/dartz.dart';
import 'package:doctor_application/data/network/failure.dart';
import 'package:doctor_application/data/network/requests.dart';
import 'package:doctor_application/domain/models/models.dart';


abstract class Repository{
  Future<Either<Failure, LoginOrVerificationOrAddReservationModel>> login(LoginOrResendOtpRequest loginRequest);
  Future<Either<Failure, LoginOrVerificationOrAddReservationModel>> verification(VerificationRequest verificationRequest);
  Future<Either<Failure, RegisterModel>> register(RegisterRequest registerRequest);
  Future<Either<Failure, LoginOrVerificationOrAddReservationModel>> resendOtp(LoginOrResendOtpRequest loginRequest);
  Future<Either<Failure, DepartmentsModel>> getDepartments();
  Future<Either<Failure, DoctorsModel>> getDoctors(String departmentId);
  Future<Either<Failure, DoctorAllDataModel>> getDoctor(String doctorId);
  Future<Either<Failure, ActiveOrDoneOrCanceledReservationsModel>> getActiveReservations(String patientId);
  Future<Either<Failure, ActiveOrDoneOrCanceledReservationsModel>> getDoneReservations(String patientId);
  Future<Either<Failure, ActiveOrDoneOrCanceledReservationsModel>> getCancelledReservations(String patientId);
  Future<Either<Failure, ProfileModel>> getProfile(String patientId);
  Future<Either<Failure, AddOrCancelOrDoneOrUpdateReservationModel>> addReservation(AddReservationRequest addReservationRequest);
  Future<Either<Failure, AddOrCancelOrDoneOrUpdateReservationModel>> updateReservation(UpdateReservationRequest updateReservationRequest);
  Future<Either<Failure, AddOrCancelOrDoneOrUpdateReservationModel>> cancelReservation(String reservationId);
  Future<Either<Failure, AddOrCancelOrDoneOrUpdateReservationModel>> doneReservation(String reservationId);
}