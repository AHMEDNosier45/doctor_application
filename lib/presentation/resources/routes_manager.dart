import 'package:flutter/material.dart';
import 'package:doctor_application/app/di.dart';
import 'package:doctor_application/presentation/authentication/auth_view.dart';
import 'package:doctor_application/presentation/doctor_details/doctor_details_view.dart';
import 'package:doctor_application/presentation/governorates/governorates_view.dart';
import 'package:doctor_application/presentation/main/main_view.dart';
import 'package:doctor_application/presentation/on_boarding/on_boarding_view.dart';
import 'package:doctor_application/presentation/profile/profile_view.dart';
import 'package:doctor_application/presentation/reschedule_reservation/reschedule_reservation_view.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';
import 'package:doctor_application/presentation/specialization_details/specialization_details_view.dart';
import 'package:doctor_application/presentation/splash/splash_view.dart';
import 'package:doctor_application/presentation/verification/verification_view.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String authRoute = '/auth';
  static const String verificationRoute = '/verification';
  static const String mainRoute = '/main';
  static const String specializationDetailsRoute = '/specializationDetails';
  static const String doctorDetailsRoute = '/doctorDetails';
  static const String profileRoute = '/profile';
  static const String rescheduleReservationRoute = '/rescheduleReservation';
  static const String governoratesRoute = '/governorates';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.authRoute:
        initLoginModule();
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const AuthView());
      case Routes.verificationRoute:
        String phoneNumber = settings.arguments.toString();
        initVerificationModule();
        return MaterialPageRoute(
            builder: (_) => VerificationView(phoneNumber: phoneNumber));
      case Routes.mainRoute:
        Map args = settings.arguments as Map;
        int pageIndex = args['pageIndex'];
        initHomeModule();
        return MaterialPageRoute(
            builder: (_) => MainView(
                  pageIndex: pageIndex,
                ));
      case Routes.specializationDetailsRoute:
        Map args = settings.arguments as Map;
        String departmentId = args['departmentId'];
        String departmentName = args['departmentName'];
        String governorate = args['governorate'];
        initSpecializationDetailsModule();
        return MaterialPageRoute(
            builder: (_) => SpecializationDetailsView(
              governorate: governorate,
                  departmentId: departmentId,
                  departmentName: departmentName,
                ));
      case Routes.doctorDetailsRoute:
        String doctorId = settings.arguments.toString();
        initDoctorDetailsModule();
        return MaterialPageRoute(
            builder: (_) => DoctorDetailsView(
                  doctorId: doctorId,
                ));
      case Routes.profileRoute:
        initProfileModule();
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case Routes.rescheduleReservationRoute:
        Map args = settings.arguments as Map;
        String doctorId = args['doctorId'];
        String reservationId = args['reservationId'];
        String currentSchedule = args['currentSchedule'];
        DateTime currentDate = args['currentDate'];
        initDoctorDetailsModule();
        initRescheduleReservationModule();
        return MaterialPageRoute(
          builder: (_) => RescheduleReservationView(
            doctorId: doctorId,
            reservationId: reservationId,
            currentSchedule: currentSchedule,
            currentDate: currentDate,
          ),
        );
      case Routes.governoratesRoute:
        Map args = settings.arguments as Map;
        String departmentId = args['departmentId'];
        String departmentName = args['departmentName'];
        initDoctorDetailsModule();
        initRescheduleReservationModule();
        return MaterialPageRoute(
          builder: (_) => GovernoratesView(
            departmentId: departmentId,
            departmentName: departmentName,
          ),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(
                child: Text(AppStrings.noRouteFound),
              ),
            ));
  }
}
