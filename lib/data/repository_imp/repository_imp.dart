import 'package:dartz/dartz.dart';
import 'package:doctor_application/app/extensions.dart';
import 'package:doctor_application/data/data_source/remote_data_source.dart';
import 'package:doctor_application/data/mappers/mappers.dart';
import 'package:doctor_application/data/network/error_handler.dart';
import 'package:doctor_application/data/network/failure.dart';
import 'package:doctor_application/data/network/network_info.dart';
import 'package:doctor_application/data/network/requests.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/repository/repository.dart';

class RepositoryImp implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImp(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, LoginOrVerificationOrAddReservationModel>> login(LoginOrResendOtpRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == '200') {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(response.status.orEmpty(), response.message.orEmpty()),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, LoginOrVerificationOrAddReservationModel>> verification(VerificationRequest verificationRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.verification(verificationRequest);

        if (response.status == '200') {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(response.status.orEmpty(), response.message.orEmpty()),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, RegisterModel>> register(RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      // try {
        final response =
            await _remoteDataSource.register(registerRequest);

        if (response.status == '200') {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(response.status.orEmpty(),
                response.message ?? ResponseMessage.DEFAULT),
          );
        }
      // } catch (error) {
      //   return Left(ErrorHandler.handle(error).failure);
      // }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, LoginOrVerificationOrAddReservationModel>> resendOtp(LoginOrResendOtpRequest loginOrResendOtpRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.resendOtp(loginOrResendOtpRequest);

        if (response.status == '200') {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(response.status.orEmpty(), response.message.orEmpty()),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, DepartmentsModel>> getDepartments() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getDepartments();

        if (response.status == '200') {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(response.status.orEmpty(), response.message.orEmpty()),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, DoctorsModel>> getDoctors(String departmentId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getDoctors(departmentId);

        if (response.status == '200') {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(response.status.orEmpty(), response.message.orEmpty()),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, DoctorAllDataModel>> getDoctor(String doctorId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getDoctor(doctorId);

        if (response.status == '200') {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(response.status.orEmpty(), response.message.orEmpty()),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }


  @override
  Future<Either<Failure, ActiveOrDoneOrCanceledReservationsModel>> getActiveReservations(String patientId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getActiveReservations(patientId);

        if (response.status == '200') {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(response.status.orEmpty(), response.message.orEmpty()),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ActiveOrDoneOrCanceledReservationsModel>> getDoneReservations(String patientId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getDoneReservations(patientId);

        if (response.status == '200') {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(response.status.orEmpty(), response.message.orEmpty()),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ActiveOrDoneOrCanceledReservationsModel>> getCancelledReservations(String patientId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getCancelledReservations(patientId);

        if (response.status == '200') {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(response.status.orEmpty(), response.message.orEmpty()),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> getProfile(String patientId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getProfile(patientId);

        if (response.status == '200') {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(response.status.orEmpty(), response.message.orEmpty()),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }


  @override
  Future<Either<Failure, AddOrCancelOrDoneOrUpdateReservationModel>> addReservation(AddReservationRequest addReservationRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.addReservation(addReservationRequest);

        if (response.status == '200') {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(response.status.orEmpty(), response.message.orEmpty()),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }


  @override
  Future<Either<Failure, AddOrCancelOrDoneOrUpdateReservationModel>> updateReservation(UpdateReservationRequest updateReservationRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.updateReservation(updateReservationRequest);

        if (response.status == '200') {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(response.status.orEmpty(), response.message.orEmpty()),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, AddOrCancelOrDoneOrUpdateReservationModel>> cancelReservation(String reservationId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.cancelReservation(reservationId);

        if (response.status == '200') {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(response.status.orEmpty(), response.message.orEmpty()),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, AddOrCancelOrDoneOrUpdateReservationModel>> doneReservation(String reservationId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.doneReservation(reservationId);

        if (response.status == '200') {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(response.status.orEmpty(), response.message.orEmpty()),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
