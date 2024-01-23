class LoginOrResendOtpRequest {
  String phoneNumber;

  LoginOrResendOtpRequest(this.phoneNumber);
}

class RegisterRequest {
  String name;
  String phoneNumber;
  String dateOfBirth;

  RegisterRequest(this.name, this.phoneNumber, this.dateOfBirth);
}

class VerificationRequest {
  String phoneNumber;
  String verifyCode;

  VerificationRequest(this.phoneNumber,this.verifyCode);
}

class AddReservationRequest {
  String patientId;
  String doctorId;
  String scheduleId;
  String dateTime;

  AddReservationRequest(this.patientId,this.doctorId,this.scheduleId,this.dateTime);
}

class UpdateReservationRequest {
  String reservationId;
  String scheduleId;
  String dateTime;

  UpdateReservationRequest(this.reservationId, this.scheduleId,this.dateTime);
}

// doctor mode

class DoctorRegisterRequest {
  String name;
  String phoneNumber;
  String department;
  String address;
  int fee;

  DoctorRegisterRequest(this.name, this.phoneNumber, this.department, this.address,this.fee);
}
