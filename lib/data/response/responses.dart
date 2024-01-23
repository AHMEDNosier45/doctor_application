// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

// Auth Response

@JsonSerializable()
class LoginOrVerificationResponse {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'body')
  String? id;

  LoginOrVerificationResponse(this.status,this.message,this.id);

  factory LoginOrVerificationResponse.fromJson(Map<String, dynamic> json) => _$LoginOrVerificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginOrVerificationResponseToJson(this);
}

@JsonSerializable()
class RegisterBodyResponse {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'mobile')
  String? mobile;
  @JsonKey(name: 'dob')
  String? dateOfBirth;


  RegisterBodyResponse(this.id,this.name,this.mobile,this.dateOfBirth);

  factory RegisterBodyResponse.fromJson(Map<String, dynamic> json) => _$RegisterBodyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterBodyResponseToJson(this);
}

@JsonSerializable()
class RegisterResponse {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'body')
  RegisterBodyResponse? body;

  RegisterResponse(this.status,this.message,this.body);

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}


// Departments Response


@JsonSerializable()
class DepartmentResponse {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'desc')
  String? description;



  DepartmentResponse(this.id,this.name,this.description);

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) => _$DepartmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentResponseToJson(this);
}

@JsonSerializable()
class DepartmentsResponse {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'body')
  List<DepartmentResponse>? departments;

  DepartmentsResponse(this.status,this.message,this.departments);

  factory DepartmentsResponse.fromJson(Map<String, dynamic> json) => _$DepartmentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentsResponseToJson(this);
}

// Doctors Response


@JsonSerializable()
class DoctorResponse {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'mobile')
  String? phoneNumber;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'desc')
  String? description;
  @JsonKey(name: 'governorate')
  String? governorate;
  @JsonKey(name: 'fee')
  int? fee;
  @JsonKey(name: 'dept')
  DepartmentResponse? department;
  @JsonKey(name: 'schedules')
  List<DoctorScheduleResponse>? schedules;



  DoctorResponse(this.id, this.name, this.phoneNumber, this.address, this.description, this.governorate, this.fee, this.department,
      this.schedules);

  factory DoctorResponse.fromJson(Map<String, dynamic> json) => _$DoctorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorResponseToJson(this);
}

@JsonSerializable()
class DoctorsResponse {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'body')
  List<DoctorResponse>? doctors;

  DoctorsResponse(this.status,this.message,this.doctors);

  factory DoctorsResponse.fromJson(Map<String, dynamic> json) => _$DoctorsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorsResponseToJson(this);
}


// Doctor Details Response


@JsonSerializable()
class DoctorScheduleResponse {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'fromHr')
  int? fromHr;
  @JsonKey(name: 'fromMin')
  int? fromMin;
  @JsonKey(name: 'toHr')
  int? toHr;
  @JsonKey(name: 'toMin')
  int? toMin;
  @JsonKey(name: 'day')
  int? weekDayNUmber;


  DoctorScheduleResponse(this.id, this.fromHr, this.fromMin, this.toHr,
      this.toMin, this.weekDayNUmber);

  factory DoctorScheduleResponse.fromJson(Map<String, dynamic> json) => _$DoctorScheduleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorScheduleResponseToJson(this);
}


@JsonSerializable()
class DoctorDetailsResponse {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'mobile')
  String? phoneNumber;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'desc')
  String? description;
  @JsonKey(name: 'governorate')
  String? governorate;
  @JsonKey(name: 'fee')
  int? fee;
  @JsonKey(name: 'dept')
  DepartmentResponse? department;
  @JsonKey(name: 'schedules')
  List<DoctorScheduleResponse>? schedules;
  @JsonKey(name: 'reservations')
  List<String>? reservations;


  DoctorDetailsResponse(this.id, this.name, this.phoneNumber, this.address, this.description, this.governorate,this.fee, this.department,
      this.schedules, this.reservations);

  factory DoctorDetailsResponse.fromJson(Map<String, dynamic> json) => _$DoctorDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDetailsResponseToJson(this);
}

@JsonSerializable()
class DoctorAllDataResponse {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'body')
  DoctorDetailsResponse? doctorDetails;

  DoctorAllDataResponse(this.status,this.message,this.doctorDetails);

  factory DoctorAllDataResponse.fromJson(Map<String, dynamic> json) => _$DoctorAllDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorAllDataResponseToJson(this);
}

// Reservations Response

@JsonSerializable()
class ReservationResponse {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'doctor')
  DoctorDetailsResponse? doctor;
  @JsonKey(name: 'schedule')
  DoctorScheduleResponse? schedule;
  @JsonKey(name: 'date')
  String? date;


  ReservationResponse(this.id, this.doctor, this.schedule, this.date);

  factory ReservationResponse.fromJson(Map<String, dynamic> json) => _$ReservationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationResponseToJson(this);
}


@JsonSerializable()
class ActiveOrDoneOrCanceledReservationsResponse {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'body')
  List<ReservationResponse>? reservations;

  ActiveOrDoneOrCanceledReservationsResponse(this.status,this.message,this.reservations);

  factory ActiveOrDoneOrCanceledReservationsResponse.fromJson(Map<String, dynamic> json) => _$ActiveOrDoneOrCanceledReservationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveOrDoneOrCanceledReservationsResponseToJson(this);
}


// Profile Response

@JsonSerializable()
class PatientResponse {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'mobile')
  String? phoneNumber;
  @JsonKey(name: 'dob')
  String? dateOfBirth;


  PatientResponse(this.id, this.name, this.phoneNumber, this.dateOfBirth);

  factory PatientResponse.fromJson(Map<String, dynamic> json) => _$PatientResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientResponseToJson(this);
}


@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'body')
  PatientResponse patient;

  ProfileResponse(this.status,this.message,this.patient);

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}


// Add Or Cancel or Done or Update Reservation Response

@JsonSerializable()
class AddOrCancelOrDoneOrUpdateReservationResponse {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'message')
  String? message;

  AddOrCancelOrDoneOrUpdateReservationResponse(this.status,this.message);

  factory AddOrCancelOrDoneOrUpdateReservationResponse.fromJson(Map<String, dynamic> json) => _$AddOrCancelOrDoneOrUpdateReservationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddOrCancelOrDoneOrUpdateReservationResponseToJson(this);
}

