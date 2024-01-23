// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginOrVerificationResponse _$LoginOrVerificationResponseFromJson(
        Map<String, dynamic> json) =>
    LoginOrVerificationResponse(
      json['status'] as String?,
      json['message'] as String?,
      json['body'] as String?,
    );

Map<String, dynamic> _$LoginOrVerificationResponseToJson(
        LoginOrVerificationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'body': instance.id,
    };

RegisterBodyResponse _$RegisterBodyResponseFromJson(
        Map<String, dynamic> json) =>
    RegisterBodyResponse(
      json['_id'] as String?,
      json['name'] as String?,
      json['mobile'] as String?,
      json['dob'] as String?,
    );

Map<String, dynamic> _$RegisterBodyResponseToJson(
        RegisterBodyResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'mobile': instance.mobile,
      'dob': instance.dateOfBirth,
    };

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      json['status'] as String?,
      json['message'] as String?,
      json['body'] == null
          ? null
          : RegisterBodyResponse.fromJson(json['body'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'body': instance.body,
    };

DepartmentResponse _$DepartmentResponseFromJson(Map<String, dynamic> json) =>
    DepartmentResponse(
      json['_id'] as String?,
      json['name'] as String?,
      json['desc'] as String?,
    );

Map<String, dynamic> _$DepartmentResponseToJson(DepartmentResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'desc': instance.description,
    };

DepartmentsResponse _$DepartmentsResponseFromJson(Map<String, dynamic> json) =>
    DepartmentsResponse(
      json['status'] as String?,
      json['message'] as String?,
      (json['body'] as List<dynamic>?)
          ?.map((e) => DepartmentResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DepartmentsResponseToJson(
        DepartmentsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'body': instance.departments,
    };

DoctorResponse _$DoctorResponseFromJson(Map<String, dynamic> json) =>
    DoctorResponse(
      json['_id'] as String?,
      json['name'] as String?,
      json['mobile'] as String?,
      json['address'] as String?,
      json['desc'] as String?,
      json['governorate'] as String?,
      json['fee'] as int?,
      json['dept'] == null
          ? null
          : DepartmentResponse.fromJson(json['dept'] as Map<String, dynamic>),
      (json['schedules'] as List<dynamic>?)
          ?.map(
              (e) => DoctorScheduleResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DoctorResponseToJson(DoctorResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'mobile': instance.phoneNumber,
      'address': instance.address,
      'desc': instance.description,
      'governorate': instance.governorate,
      'fee': instance.fee,
      'dept': instance.department,
      'schedules': instance.schedules,
    };

DoctorsResponse _$DoctorsResponseFromJson(Map<String, dynamic> json) =>
    DoctorsResponse(
      json['status'] as String?,
      json['message'] as String?,
      (json['body'] as List<dynamic>?)
          ?.map((e) => DoctorResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DoctorsResponseToJson(DoctorsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'body': instance.doctors,
    };

DoctorScheduleResponse _$DoctorScheduleResponseFromJson(
        Map<String, dynamic> json) =>
    DoctorScheduleResponse(
      json['_id'] as String?,
      json['fromHr'] as int?,
      json['fromMin'] as int?,
      json['toHr'] as int?,
      json['toMin'] as int?,
      json['day'] as int?,
    );

Map<String, dynamic> _$DoctorScheduleResponseToJson(
        DoctorScheduleResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fromHr': instance.fromHr,
      'fromMin': instance.fromMin,
      'toHr': instance.toHr,
      'toMin': instance.toMin,
      'day': instance.weekDayNUmber,
    };

DoctorDetailsResponse _$DoctorDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    DoctorDetailsResponse(
      json['_id'] as String?,
      json['name'] as String?,
      json['mobile'] as String?,
      json['address'] as String?,
      json['desc'] as String?,
      json['governorate'] as String?,
      json['fee'] as int?,
      json['dept'] == null
          ? null
          : DepartmentResponse.fromJson(json['dept'] as Map<String, dynamic>),
      (json['schedules'] as List<dynamic>?)
          ?.map(
              (e) => DoctorScheduleResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['reservations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DoctorDetailsResponseToJson(
        DoctorDetailsResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'mobile': instance.phoneNumber,
      'address': instance.address,
      'desc': instance.description,
      'governorate': instance.governorate,
      'fee': instance.fee,
      'dept': instance.department,
      'schedules': instance.schedules,
      'reservations': instance.reservations,
    };

DoctorAllDataResponse _$DoctorAllDataResponseFromJson(
        Map<String, dynamic> json) =>
    DoctorAllDataResponse(
      json['status'] as String?,
      json['message'] as String?,
      json['body'] == null
          ? null
          : DoctorDetailsResponse.fromJson(
              json['body'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DoctorAllDataResponseToJson(
        DoctorAllDataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'body': instance.doctorDetails,
    };

ReservationResponse _$ReservationResponseFromJson(Map<String, dynamic> json) =>
    ReservationResponse(
      json['_id'] as String?,
      json['doctor'] == null
          ? null
          : DoctorDetailsResponse.fromJson(
              json['doctor'] as Map<String, dynamic>),
      json['schedule'] == null
          ? null
          : DoctorScheduleResponse.fromJson(
              json['schedule'] as Map<String, dynamic>),
      json['date'] as String?,
    );

Map<String, dynamic> _$ReservationResponseToJson(
        ReservationResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'doctor': instance.doctor,
      'schedule': instance.schedule,
      'date': instance.date,
    };

ActiveOrDoneOrCanceledReservationsResponse
    _$ActiveOrDoneOrCanceledReservationsResponseFromJson(
            Map<String, dynamic> json) =>
        ActiveOrDoneOrCanceledReservationsResponse(
          json['status'] as String?,
          json['message'] as String?,
          (json['body'] as List<dynamic>?)
              ?.map((e) =>
                  ReservationResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$ActiveOrDoneOrCanceledReservationsResponseToJson(
        ActiveOrDoneOrCanceledReservationsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'body': instance.reservations,
    };

PatientResponse _$PatientResponseFromJson(Map<String, dynamic> json) =>
    PatientResponse(
      json['_id'] as String?,
      json['name'] as String?,
      json['mobile'] as String?,
      json['dob'] as String?,
    );

Map<String, dynamic> _$PatientResponseToJson(PatientResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'mobile': instance.phoneNumber,
      'dob': instance.dateOfBirth,
    };

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      json['status'] as String?,
      json['message'] as String?,
      PatientResponse.fromJson(json['body'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'body': instance.patient,
    };

AddOrCancelOrDoneOrUpdateReservationResponse
    _$AddOrCancelOrDoneOrUpdateReservationResponseFromJson(
            Map<String, dynamic> json) =>
        AddOrCancelOrDoneOrUpdateReservationResponse(
          json['status'] as String?,
          json['message'] as String?,
        );

Map<String, dynamic> _$AddOrCancelOrDoneOrUpdateReservationResponseToJson(
        AddOrCancelOrDoneOrUpdateReservationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
