
//OnBoarding Models

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject{
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject,this.numOfSlides,this.currentIndex);
}

 // Auth Models

class LoginOrVerificationOrAddReservationModel {
  String status;
  String message;
  String id;

  LoginOrVerificationOrAddReservationModel(this.status,this.message,this.id);
}

class RegisterBodyModel {
  String id;
  String name;
  String mobile;
  String dateOfBirth;


  RegisterBodyModel(this.id,this.name,this.mobile,this.dateOfBirth);
}

class RegisterModel {
  String status;
  String message;
  RegisterBodyModel? body;

  RegisterModel(this.status,this.message,this.body);
}


// Departments Models



class DepartmentModel {
  String id;
  String name;
  String description;

  DepartmentModel(this.id,this.name,this.description);
}

class DepartmentsModel {
  String status;
  String message;
  List<DepartmentModel>? departments;

  DepartmentsModel(this.status,this.message,this.departments);
}


// Doctors Models


class DoctorModel {
  String id;
  String name;
  String phoneNumber;
  String address;
  String description;
  String governorate;
  int fee;
  DepartmentModel department;
  List<DoctorScheduleModel>? schedules;



  DoctorModel(this.id, this.name, this.phoneNumber, this.address, this.description, this.governorate,this.fee, this.department,
      this.schedules);
}

class DoctorsModel {
  String status;
  String message;
  List<DoctorModel>? doctors;

  DoctorsModel(this.status,this.message,this.doctors);
}


// Doctor Details Models


class DoctorScheduleModel {
  String id;
  int fromHr;
  int fromMin;
  int toHr;
  int toMin;
  int weekDayNUmber;


  DoctorScheduleModel(this.id, this.fromHr, this.fromMin, this.toHr,
      this.toMin, this.weekDayNUmber);
}

class DoctorDetailsModel {
  String id;
  String name;
  String phoneNumber;
  String address;
  String description;
  String governorate;
  int fee;
  DepartmentModel? department;
  List<DoctorScheduleModel>? schedules;
  List<String>? reservations;


  DoctorDetailsModel(this.id, this.name, this.phoneNumber, this.address, this.description, this.governorate,this.fee, this.department,
      this.schedules, this.reservations);
}

class DoctorAllDataModel {
  String status;
  String message;
  DoctorDetailsModel? doctorDetails;

  DoctorAllDataModel(this.status,this.message,this.doctorDetails);
}


// Patient Reservations Model


class ReservationModel {
  String id;
  bool isDone;
  DoctorDetailsModel? doctor;
  DoctorScheduleModel? schedule;
  String date;


  ReservationModel(this.id, this.doctor, this.schedule, this.date, {this.isDone = false});
}

class ActiveOrDoneOrCanceledReservationsModel {
  String status;
  String message;
  List<ReservationModel>? reservations;

  ActiveOrDoneOrCanceledReservationsModel(this.status,this.message,this.reservations);
}


//Patient Profile Model


class PatientModel {
  String id;
  String name;
  String phoneNumber;
  String dateOfBirth;


  PatientModel(this.id, this.name, this.phoneNumber, this.dateOfBirth);
}

class ProfileModel {
  String status;
  String message;
  PatientModel? patient;

  ProfileModel(this.status,this.message,this.patient);
}

// Add Or Cancel or Done or Update Reservation model

class AddOrCancelOrDoneOrUpdateReservationModel {
  String status;
  String message;

  AddOrCancelOrDoneOrUpdateReservationModel(this.status,this.message);
}