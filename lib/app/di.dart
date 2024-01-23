import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:doctor_application/app/app_prefs.dart';
import 'package:doctor_application/data/data_source/remote_data_source.dart';
import 'package:doctor_application/data/network/app_api.dart';
import 'package:doctor_application/data/network/dio_factory.dart';
import 'package:doctor_application/data/network/network_info.dart';
import 'package:doctor_application/data/repository_imp/repository_imp.dart';
import 'package:doctor_application/domain/repository/repository.dart';
import 'package:doctor_application/domain/useCase/add_reservation_use_case.dart';
import 'package:doctor_application/domain/useCase/cancel_reservation_use_case.dart';
import 'package:doctor_application/domain/useCase/done_reservation_use_case.dart';
import 'package:doctor_application/domain/useCase/get_cancelled_reservations_use_case.dart';
import 'package:doctor_application/domain/useCase/get_departments_use_case.dart';
import 'package:doctor_application/domain/useCase/get_doctor_use_case.dart';
import 'package:doctor_application/domain/useCase/get_doctors_use_case.dart';
import 'package:doctor_application/domain/useCase/get_done_reservations_use_case.dart';
import 'package:doctor_application/domain/useCase/get_profile_use_case.dart';
import 'package:doctor_application/domain/useCase/get_reservations_use_case.dart';
import 'package:doctor_application/domain/useCase/login_use_case.dart';
import 'package:doctor_application/domain/useCase/register_use_case.dart';
import 'package:doctor_application/domain/useCase/resend_otp_use_case.dart';
import 'package:doctor_application/domain/useCase/update_reservation_use_case.dart';
import 'package:doctor_application/domain/useCase/verification_use_case.dart';
import 'package:doctor_application/presentation/authentication/login/login_view_model.dart';
import 'package:doctor_application/presentation/authentication/register/register_view_model.dart';
import 'package:doctor_application/presentation/doctor_details/doctor_details_view_model.dart';
import 'package:doctor_application/presentation/main/pages/home/home_view_model.dart';
import 'package:doctor_application/presentation/main/pages/reservations/active_reservations_view/active_reservations_view_model.dart';
import 'package:doctor_application/presentation/main/pages/reservations/canceled_reservations/cancelled_reservations_view_model.dart';
import 'package:doctor_application/presentation/main/pages/reservations/done_reservations/done_reservations_view_model.dart';
import 'package:doctor_application/presentation/profile/profile_view_model.dart';
import 'package:doctor_application/presentation/reschedule_reservation/reschedule_reservation_view_model.dart';
import 'package:doctor_application/presentation/specialization_details/specialization_details_view_model.dart';
import 'package:doctor_application/presentation/verification/verification_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();
  //app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImp(instance<AppServiceClient>()));

  // repository

  instance.registerLazySingleton<Repository>(
      () => RepositoryImp(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initVerificationModule() {
  if (!GetIt.I.isRegistered<VerificationUseCase>()) {
    instance.registerFactory<VerificationUseCase>(() => VerificationUseCase(instance()));
    instance.registerFactory<ResendOtpUseCase>(() => ResendOtpUseCase(instance()));
    instance.registerFactory<VerificationViewModel>(() => VerificationViewModel(instance(),instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(instance()));
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<GetDepartmentsUseCase>()) {
    instance.registerFactory<GetDepartmentsUseCase>(() => GetDepartmentsUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
    instance.registerFactory<CancelReservationUseCase>(() => CancelReservationUseCase(instance()));
    instance.registerFactory<DoneReservationUseCase>(() => DoneReservationUseCase(instance()));
    instance.registerFactory<GetActiveReservationsUseCase>(() => GetActiveReservationsUseCase(instance()));
    instance.registerFactory<GetCancelledReservationsUseCase>(() => GetCancelledReservationsUseCase(instance()));
    instance.registerFactory<GetDoneReservationsUseCase>(() => GetDoneReservationsUseCase(instance()));
    instance.registerFactory<ActiveReservationsViewModel>(() => ActiveReservationsViewModel(instance(),instance(),instance()));
    instance.registerFactory<CancelledReservationsViewModel>(() => CancelledReservationsViewModel(instance(),instance(),instance()));
    instance.registerFactory<DoneReservationsViewModel>(() => DoneReservationsViewModel(instance(),instance(),instance()));
  }
}

initRescheduleReservationModule(){
  if (!GetIt.I.isRegistered<UpdateReservationUseCase>()) {
    instance.registerFactory<UpdateReservationUseCase>(() =>
        UpdateReservationUseCase(instance()));
    instance.registerFactory<RescheduleReservationViewModel>(() =>
        RescheduleReservationViewModel(instance(), instance()));
  }
}

initSpecializationDetailsModule() {
  if (!GetIt.I.isRegistered<GetDoctorsUseCase>()) {
    instance.registerFactory<GetDoctorsUseCase>(() => GetDoctorsUseCase(instance()));
    instance.registerFactory<SpecializationDetailsViewModel>(() => SpecializationDetailsViewModel(instance()));
  }
}

initDoctorDetailsModule() {
  if (!GetIt.I.isRegistered<GetDoctorUseCase>()) {
    instance.registerFactory<GetDoctorUseCase>(() => GetDoctorUseCase(instance()));
    instance.registerFactory<AddReservationUseCase>(() => AddReservationUseCase(instance()));
    instance.registerFactory<DoctorDetailsViewModel>(() => DoctorDetailsViewModel(instance(),instance()));
  }
}

initProfileModule() {
  if (!GetIt.I.isRegistered<GetProfileUseCase>()) {
    instance.registerFactory<GetProfileUseCase>(() => GetProfileUseCase(instance()));
    instance.registerFactory<ProfileViewModel>(() => ProfileViewModel(instance()));
  }
}
