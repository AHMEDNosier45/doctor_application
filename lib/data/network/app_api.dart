import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:doctor_application/app/constants.dart';
import 'package:doctor_application/data/response/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("patient/logIn")
  Future<LoginOrVerificationResponse> login(
    @Field("mobile") String phoneNumber,
  );

  @POST("patient")
  Future<RegisterResponse> register(
    @Field("name") String name,
    @Field("mobile") String phoneNumber,
    @Field("dob") String dateOfBirth,
  );

  @POST("patient/verifyOtp")
  Future<LoginOrVerificationResponse> verification(
    @Field("mobile") String phoneNumber,
    @Field("otpCode") String verifyCode,
  );

  @POST("patient/resendOtp")
  Future<LoginOrVerificationResponse> resendOtp(
    @Field("mobile") String phoneNumber,
  );

  @GET("lookup/depts")
  Future<DepartmentsResponse> getDepartments();

  @GET("doctor/dept/{departmentId}")
  Future<DoctorsResponse> getDoctors(@Path("departmentId") String departmentId);

  @GET("doctor/{doctorId}")
  Future<DoctorAllDataResponse> getDoctor(@Path("doctorId") String doctorId);

  @GET("patient/reservations/{patientId}")
  Future<ActiveOrDoneOrCanceledReservationsResponse> getActiveReservations(
      @Path("patientId") String patientId);

  @GET("patient/doneReservations/{patientId}")
  Future<ActiveOrDoneOrCanceledReservationsResponse> getDoneReservations(
      @Path("patientId") String patientId);

  @GET("patient/cancelledReservations/{patientId}")
  Future<ActiveOrDoneOrCanceledReservationsResponse> getCancelledReservations(
      @Path("patientId") String patientId);

  @GET("patient/{patientId}")
  Future<ProfileResponse> getProfile(@Path("patientId") String patientId);

  @POST("reservation")
  Future<AddOrCancelOrDoneOrUpdateReservationResponse> addReservation(
    @Field("patientId") String patientId,
    @Field("doctorId") String doctorId,
    @Field("scheduleId") String scheduleId,
    @Field("dateTime") String dateTime,
  );

  @PUT("reservation/cancelledReservation/{reservationId}")
  Future<AddOrCancelOrDoneOrUpdateReservationResponse> cancelReservation(
      @Path("reservationId") String reservationId,
      );

  @PUT("reservation/doneReservation/{reservationId}")
  Future<AddOrCancelOrDoneOrUpdateReservationResponse> doneReservation(
      @Path("reservationId") String reservationId,
      );

  @PUT("reservation/{reservationId}")
  Future<AddOrCancelOrDoneOrUpdateReservationResponse> updateReservation(
      @Path("reservationId") String reservationId,
      @Field("scheduleId") String scheduleId,
      @Field("dateTime") String dateTime,
      );
}
