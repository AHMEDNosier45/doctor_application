import 'package:doctor_application/data/network/app_api.dart';
import 'package:doctor_application/data/network/requests.dart';
import 'package:doctor_application/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<LoginOrVerificationResponse> login(
      LoginOrResendOtpRequest loginOrResendOtpRequest);
  Future<RegisterResponse> register(RegisterRequest registerRequest);
  Future<LoginOrVerificationResponse> verification(
      VerificationRequest verificationRequest);
  Future<LoginOrVerificationResponse> resendOtp(
      LoginOrResendOtpRequest loginOrResendOtpRequest);
  Future<DepartmentsResponse> getDepartments();
  Future<DoctorsResponse> getDoctors(String departmentId);
  Future<DoctorAllDataResponse> getDoctor(String doctorId);
  Future<ActiveOrDoneOrCanceledReservationsResponse> getActiveReservations(String patientId);
  Future<ActiveOrDoneOrCanceledReservationsResponse> getDoneReservations(String patientId);
  Future<ActiveOrDoneOrCanceledReservationsResponse> getCancelledReservations(String patientId);
  Future<ProfileResponse> getProfile(String patientId);
  Future<AddOrCancelOrDoneOrUpdateReservationResponse> addReservation(AddReservationRequest addReservationRequest);
  Future<AddOrCancelOrDoneOrUpdateReservationResponse> updateReservation(UpdateReservationRequest updateReservationRequest);
  Future<AddOrCancelOrDoneOrUpdateReservationResponse> cancelReservation(String reservationId);
  Future<AddOrCancelOrDoneOrUpdateReservationResponse> doneReservation(String reservationId);
}

class RemoteDataSourceImp implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImp(this._appServiceClient);

  @override
  Future<LoginOrVerificationResponse> login(
      LoginOrResendOtpRequest loginRequest) async {
    return await _appServiceClient.login(loginRequest.phoneNumber);
  }

  @override
  Future<LoginOrVerificationResponse> verification(
      VerificationRequest verificationRequest) async {
    return await _appServiceClient.verification(
        verificationRequest.phoneNumber, verificationRequest.verifyCode);
  }

  @override
  Future<RegisterResponse> register(RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
      registerRequest.name,
      registerRequest.phoneNumber,
      registerRequest.dateOfBirth,
    );
  }

  @override
  Future<LoginOrVerificationResponse> resendOtp(
      LoginOrResendOtpRequest loginRequest) async {
    return await _appServiceClient.resendOtp(loginRequest.phoneNumber);
  }

  @override
  Future<DepartmentsResponse> getDepartments() async {
    return await _appServiceClient.getDepartments();
  }

  @override
  Future<DoctorsResponse> getDoctors(String departmentId) async {
    return await _appServiceClient.getDoctors(departmentId);
  }

  @override
  Future<DoctorAllDataResponse> getDoctor(String doctorId) async {
    return await _appServiceClient.getDoctor(doctorId);
  }

  @override
  Future<ActiveOrDoneOrCanceledReservationsResponse> getActiveReservations(String patientId) async {
    return await _appServiceClient.getActiveReservations(patientId);
  }

  @override
  Future<ActiveOrDoneOrCanceledReservationsResponse> getDoneReservations(String patientId) async {
    return await _appServiceClient.getDoneReservations(patientId);
  }

  @override
  Future<ActiveOrDoneOrCanceledReservationsResponse> getCancelledReservations(String patientId) async {
    return await _appServiceClient.getCancelledReservations(patientId);
  }

  @override
  Future<ProfileResponse> getProfile(String patientId) async {
    return await _appServiceClient.getProfile(patientId);
  }

  @override
  Future<AddOrCancelOrDoneOrUpdateReservationResponse> addReservation(
      AddReservationRequest addReservationRequest) async {
    return await _appServiceClient.addReservation(
        addReservationRequest.patientId,
        addReservationRequest.doctorId,
        addReservationRequest.scheduleId,
        addReservationRequest.dateTime,
    );
  }


  @override
  Future<AddOrCancelOrDoneOrUpdateReservationResponse> updateReservation(
      UpdateReservationRequest updateReservationRequest) async {
    return await _appServiceClient.updateReservation(
      updateReservationRequest.reservationId,
      updateReservationRequest.scheduleId,
      updateReservationRequest.dateTime,
    );
  }

  @override
  Future<AddOrCancelOrDoneOrUpdateReservationResponse> cancelReservation(String reservationId) async {
    return await _appServiceClient.cancelReservation(reservationId);
  }

  @override
  Future<AddOrCancelOrDoneOrUpdateReservationResponse> doneReservation(String reservationId) async {
    return await _appServiceClient.doneReservation(reservationId);
  }
}
