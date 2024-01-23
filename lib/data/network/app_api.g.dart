// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AppServiceClient implements AppServiceClient {
  _AppServiceClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://egada.vercel.app/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginOrVerificationResponse> login(phoneNumber) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'mobile': phoneNumber};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginOrVerificationResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'patient/logIn',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginOrVerificationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RegisterResponse> register(
    name,
    phoneNumber,
    dateOfBirth,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'name': name,
      'mobile': phoneNumber,
      'dob': dateOfBirth,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<RegisterResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'patient',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RegisterResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginOrVerificationResponse> verification(
    phoneNumber,
    verifyCode,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'mobile': phoneNumber,
      'otpCode': verifyCode,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginOrVerificationResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'patient/verifyOtp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginOrVerificationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginOrVerificationResponse> resendOtp(phoneNumber) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'mobile': phoneNumber};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginOrVerificationResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'patient/resendOtp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginOrVerificationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DepartmentsResponse> getDepartments() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DepartmentsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'lookup/depts',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DepartmentsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DoctorsResponse> getDoctors(departmentId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DoctorsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'doctor/dept/${departmentId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DoctorsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DoctorAllDataResponse> getDoctor(doctorId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DoctorAllDataResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'doctor/${doctorId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DoctorAllDataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ActiveOrDoneOrCanceledReservationsResponse> getActiveReservations(
      patientId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ActiveOrDoneOrCanceledReservationsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'patient/reservations/${patientId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        ActiveOrDoneOrCanceledReservationsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ActiveOrDoneOrCanceledReservationsResponse> getDoneReservations(
      patientId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ActiveOrDoneOrCanceledReservationsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'patient/doneReservations/${patientId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        ActiveOrDoneOrCanceledReservationsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ActiveOrDoneOrCanceledReservationsResponse> getCancelledReservations(
      patientId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ActiveOrDoneOrCanceledReservationsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'patient/cancelledReservations/${patientId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        ActiveOrDoneOrCanceledReservationsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProfileResponse> getProfile(patientId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ProfileResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'patient/${patientId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProfileResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddOrCancelOrDoneOrUpdateReservationResponse> addReservation(
    patientId,
    doctorId,
    scheduleId,
    dateTime,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'patientId': patientId,
      'doctorId': doctorId,
      'scheduleId': scheduleId,
      'dateTime': dateTime,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddOrCancelOrDoneOrUpdateReservationResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'reservation',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        AddOrCancelOrDoneOrUpdateReservationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddOrCancelOrDoneOrUpdateReservationResponse> cancelReservation(
      reservationId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddOrCancelOrDoneOrUpdateReservationResponse>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'reservation/cancelledReservation/${reservationId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        AddOrCancelOrDoneOrUpdateReservationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddOrCancelOrDoneOrUpdateReservationResponse> doneReservation(
      reservationId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddOrCancelOrDoneOrUpdateReservationResponse>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'reservation/doneReservation/${reservationId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        AddOrCancelOrDoneOrUpdateReservationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddOrCancelOrDoneOrUpdateReservationResponse> updateReservation(
    reservationId,
    scheduleId,
    dateTime,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'scheduleId': scheduleId,
      'dateTime': dateTime,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddOrCancelOrDoneOrUpdateReservationResponse>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'reservation/${reservationId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        AddOrCancelOrDoneOrUpdateReservationResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
