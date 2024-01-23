// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:doctor_application/data/network/failure.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = _handleError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.RECEIVE_TIMEOUT.getFailure();
    case DioErrorType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(error.response!.statusCode.toString(),
            error.response!.statusMessage!);
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioErrorType.unknown:
      return DataSource.DEFAULT.getFailure();
    case DioErrorType.badCertificate:
      return DataSource.BAD_CERTIFICATE.getFailure();
    case DioErrorType.connectionError:
      return DataSource.CONNECTION_ERROR.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  BAD_CERTIFICATE,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CONNECTION_ERROR,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORISED:
        return Failure(ResponseCode.UNAUTHORISED, ResponseMessage.UNAUTHORISED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.CONNECTION_ERROR:
        return Failure(ResponseCode.CONNECTION_ERROR, ResponseMessage.CONNECTION_ERROR);
      case DataSource.BAD_CERTIFICATE:
        return Failure(ResponseCode.BAD_CERTIFICATE, ResponseMessage.BAD_CERTIFICATE);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const String SUCCESS = '200';
  static const String NO_CONTENT = '204';
  static const String BAD_REQUEST = '400';
  static const String UNAUTHORISED = '401';
  static const String FORBIDDEN = '403';
  static const String INTERNAL_SERVER_ERROR = '500';
  static const String NOT_FOUND = '404';
  static const String CONNECTION_ERROR = '503';
  static const String BAD_CERTIFICATE = '502';

  // local status code
  static const String CONNECT_TIMEOUT = '-1';
  static const String CANCEL = '-2';
  static const String RECEIVE_TIMEOUT = '-3';
  static const String SEND_TIMEOUT = '-4';
  static const String CACHE_ERROR = '-5';
  static const String NO_INTERNET_CONNECTION = '-6';
  static const String DEFAULT = '-7';
}

class ResponseMessage {
  static const String SUCCESS = AppStrings.success;
  static const String NO_CONTENT = AppStrings.success;
  static const String BAD_REQUEST = AppStrings.badRequestError;
  static const String UNAUTHORISED = AppStrings.unauthorizedError;
  static const String FORBIDDEN = AppStrings.forbiddenError;
  static const String INTERNAL_SERVER_ERROR = AppStrings.internalServerError;
  static const String NOT_FOUND = AppStrings.notFoundError;
  static const String CONNECTION_ERROR = AppStrings.connectionError;
  static const String BAD_CERTIFICATE = AppStrings.badCertificate;

  // local status code
  static const String CONNECT_TIMEOUT = AppStrings.timeoutError;
  static const String CANCEL = AppStrings.defaultError;
  static const String RECEIVE_TIMEOUT = AppStrings.timeoutError;
  static const String SEND_TIMEOUT = AppStrings.timeoutError;
  static const String CACHE_ERROR = AppStrings.cacheError;
  static const String NO_INTERNET_CONNECTION = AppStrings.noInternetError;
  static const String DEFAULT = AppStrings.defaultError;
}

