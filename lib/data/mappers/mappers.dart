import 'package:doctor_application/app/extensions.dart';
import 'package:doctor_application/data/response/responses.dart';
import 'package:doctor_application/domain/models/models.dart';


// Auth Mappers

extension LoginOrVerificationResponseMapper on LoginOrVerificationResponse? {
  LoginOrVerificationOrAddReservationModel toDomain() {
    return LoginOrVerificationOrAddReservationModel(
        (this?.status).orEmpty(),
      (this?.message).orEmpty(),
      (this?.id).orEmpty(),
        );
  }
}

extension RegisterBodyResponseMapper on RegisterBodyResponse? {
  RegisterBodyModel toDomain() {
    return RegisterBodyModel(
        (this?.id).orEmpty(),
        (this?.name).orEmpty(),
        (this?.mobile).orEmpty(),
      (this?.dateOfBirth).orEmpty(),
    );
  }
}

extension RegisterResponseMapper on RegisterResponse? {
  RegisterModel toDomain() {
    return RegisterModel(
        (this?.status).orEmpty(),
    (this?.message).orEmpty(),
    this?.body.toDomain(),
    );
  }
}


// Departments Mappers

extension DepartmentResponseMapper on DepartmentResponse? {
  DepartmentModel toDomain() {
    return DepartmentModel(
        (this?.id).orEmpty(),
        (this?.name).orEmpty(),
      (this?.description).orEmpty(),
    );
  }
}

extension DepartmentsResponseMapper on DepartmentsResponse? {
  DepartmentsModel toDomain() {
    return DepartmentsModel(
        (this?.status).orEmpty(),
      (this?.message).orEmpty(),
      this?.departments?.map((departmentResponse) => departmentResponse.toDomain()).toList(),
    );
  }
}


// Doctors Mappers

extension DoctorResponseMapper on DoctorResponse? {
  DoctorModel toDomain() {
    return DoctorModel(
        (this?.id).orEmpty(),
        (this?.name).orEmpty(),
        (this?.phoneNumber).orEmpty(),
        (this?.address).orEmpty(),
        (this?.description).orEmpty(),
        (this?.governorate).orEmpty(),
        (this?.fee).orZero(),
      (this?.department).toDomain(),
      this?.schedules?.map((schedule) => schedule.toDomain()).toList(),
    );
  }
}


extension DoctorsResponseMapper on DoctorsResponse? {
  DoctorsModel toDomain() {
    return DoctorsModel(
      (this?.status).orEmpty(),
      (this?.message).orEmpty(),
      this?.doctors?.map((doctorResponse) => doctorResponse.toDomain()).toList(),
    );
  }
}

// Doctor Details Mappers

extension DoctorScheduleResponseMapper on DoctorScheduleResponse? {
  DoctorScheduleModel toDomain() {
    return DoctorScheduleModel(
      (this?.id).orEmpty(),
      (this?.fromHr).orZero(),
      (this?.fromMin).orZero(),
      (this?.toHr).orZero(),
      (this?.toMin).orZero(),
      (this?.weekDayNUmber).orZero(),
    );
  }
}

extension DoctorDetailsResponseMapper on DoctorDetailsResponse? {
  DoctorDetailsModel toDomain() {
    return DoctorDetailsModel(
      (this?.id).orEmpty(),
      (this?.name).orEmpty(),
      (this?.phoneNumber).orEmpty(),
      (this?.address).orEmpty(),
      (this?.description).orEmpty(),
      (this?.governorate).orEmpty(),
      (this?.fee).orZero(),
      this?.department.toDomain(),
      this?.schedules?.map((scheduleResponse) => scheduleResponse.toDomain()).toList(),
      this?.reservations?.map((reservationResponse) => reservationResponse).toList(),
    );
  }
}

extension DoctorAllDataResponseMapper on DoctorAllDataResponse? {
  DoctorAllDataModel toDomain() {
    return DoctorAllDataModel(
      (this?.status).orEmpty(),
      (this?.message).orEmpty(),
      this?.doctorDetails.toDomain(),
    );
  }
}

//  Reservations Mappers

extension ReservationsResponseMapper on ReservationResponse? {
  ReservationModel toDomain() {
    return ReservationModel(
      (this?.id).orEmpty(),
      this?.doctor.toDomain(),
      this?.schedule.toDomain(),
      (this?.date).orEmpty(),
    );
  }
}

extension ReservationsAllDataResponseMapper on ActiveOrDoneOrCanceledReservationsResponse? {
  ActiveOrDoneOrCanceledReservationsModel toDomain() {
    return ActiveOrDoneOrCanceledReservationsModel(
      (this?.status).orEmpty(),
      (this?.message).orEmpty(),
      this?.reservations?.map((reservationResponse) => reservationResponse.toDomain()).toList(),
    );
  }
}


//  Profile Mappers

extension ResponseMapper on PatientResponse? {
  PatientModel toDomain() {
    return PatientModel(
      (this?.id).orEmpty(),
      (this?.name).orEmpty(),
      (this?.phoneNumber).orEmpty(),
      (this?.dateOfBirth).orEmpty(),
    );
  }
}


extension ProfileResponseMapper on ProfileResponse? {
  ProfileModel toDomain() {
    return ProfileModel(
      (this?.status).orEmpty(),
      (this?.message).orEmpty(),
      this?.patient.toDomain(),
    );
  }
}

extension AddReservationResponseMapper on AddOrCancelOrDoneOrUpdateReservationResponse? {
  AddOrCancelOrDoneOrUpdateReservationModel toDomain() {
    return AddOrCancelOrDoneOrUpdateReservationModel(
      (this?.status).orEmpty(),
      (this?.message).orEmpty(),
    );
  }
}