import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:doctor_application/app/app_prefs.dart';
import 'package:doctor_application/app/di.dart';
import 'package:doctor_application/app/extensions.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:doctor_application/presentation/common/widgets/custom_app_bar.dart';
import 'package:doctor_application/presentation/doctor_details/doctor_details_view_model.dart';
import 'package:doctor_application/presentation/resources/assets_manager.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/font_manager.dart';
import 'package:doctor_application/presentation/resources/routes_manager.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';

class DoctorDetailsView extends StatefulWidget {
  final String doctorId;
  const DoctorDetailsView({Key? key, required this.doctorId}) : super(key: key);

  @override
  State<DoctorDetailsView> createState() => _DoctorDetailsViewState();
}

class _DoctorDetailsViewState extends State<DoctorDetailsView> {
  final DoctorDetailsViewModel _viewModel = instance<DoctorDetailsViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  bool isSchedules = false;

  _bind() {
    _viewModel.doctorId = widget.doctorId;
    _viewModel.start();
    _viewModel.isBookedStreamController.listen((isBooked) {
      if (isBooked) {
        // Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(context, Routes.mainRoute, ModalRoute.withName(Routes.splashRoute),arguments:
        {
          'pageIndex':1,
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(centerTitle: true, title: 'Doctor Details'),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outPutState,
        builder: (context, snapshot) {
          if(snapshot.data != null) {
            return snapshot.data!.getScreenWidget(
                context,
                contentScreenWidget: _getContentWidget(size, context),
                buttonTitle: snapshot.data!.getStateRendererType() ==
                        StateRendererType.popupSuccessState
                    ? AppStrings.ok
                    : AppStrings.retryAgain,
                retryActionFunction: () {
                  snapshot.data?.getStateRendererType() ==
                          StateRendererType.popupSuccessState
                      ? _viewModel.isBookedStreamController.add(true)
                      : _viewModel.start();
                },
              ) ??
              Container();
          }else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _getContentWidget(Size size, BuildContext context) {
    return StreamBuilder<DoctorDetailsModel>(
      stream: _viewModel.outputDoctorDetails,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                children: [
                  doctorDetailsSection1(snapshot.data!),
                  const SizedBox(height: AppSize.s5),
                  doctorDetailsSection2(snapshot.data!),
                ],
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget doctorDetailsSection1(DoctorDetailsModel doctorDetails) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: AppPadding.p5),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: AppPadding.p10,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppSize.s5),
        boxShadow: [
          BoxShadow(
            color: ColorManager.darkPrimary2.withOpacity(.4),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              ImageAssets.doctor,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: AppSize.s15,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p2),
                  child: Text(
                    'Doctor ${doctorDetails.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: FontSize.s16),
                  ),
                ),
                Text(
                  doctorDetails.description,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: ColorManager.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Contact : ',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: ColorManager.grey),
                    ),
                    InkWell(
                      overlayColor: MaterialStatePropertyAll(ColorManager.lightBlue),
                      borderRadius: BorderRadius.circular(AppSize.s10),
                      onTap: () async => await _viewModel.openWhatsAppChat((doctorDetails.phoneNumber).orEmpty()),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p10,
                            vertical: AppPadding.p5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s10),
                          border: Border.all(
                            color: ColorManager.primary,
                          ),
                        ),
                        child: Text(
                          'whatsapp',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: ColorManager.primary),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget doctorDetailsSection2(DoctorDetailsModel doctorDetails) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: AppPadding.p5),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: AppPadding.p10,
      ),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppSize.s5),
        boxShadow: [
          BoxShadow(
            color: ColorManager.darkPrimary2.withOpacity(.4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _feeAndPhoneSection(doctorDetails),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppPadding.p5),
            child: Divider(thickness: 2),
          ),
          _locationSection(doctorDetails),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppPadding.p5),
            child: Divider(thickness: 2),
          ),
          _professionPracticeCertificate(doctorDetails),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppPadding.p5),
            child: Divider(thickness: 2),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: AppPadding.p15, top: AppPadding.p5),
              child: Text(
                'Choose your appointment',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: ColorManager.error),
              ),
            ),
          ),
          _dateBar(),
          const SizedBox(height: AppSize.s20),
          _doctorSchedules(doctorDetails),
          const SizedBox(height: AppSize.s10),
          _reservationRequiredText(),
        ],
      ),
    );
  }

  Widget _feeAndPhoneSection(DoctorDetailsModel? doctorDetails) {
    return Row(
      children: [
        Icon(
          Icons.attach_money_outlined,
          color: ColorManager.darkPrimary2,
        ),
        const SizedBox(
          width: AppSize.s5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${doctorDetails?.fee.toString()} EGP',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'Consultation fees',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: ColorManager.grey),
            ),
          ],
        ),
        const SizedBox(
          width: AppSize.s15,
        ),
        Icon(
          Icons.phone,
          color: ColorManager.darkPrimary2,
        ),
        const SizedBox(
          width: AppSize.s10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (doctorDetails?.phoneNumber).orEmpty().toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'Phone Number',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: ColorManager.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _locationSection(DoctorDetailsModel doctorDetails) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          color: ColorManager.darkPrimary2,
        ),
        const SizedBox(
          width: AppSize.s10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctorDetails.address.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                'Book and you will receive the address details',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: ColorManager.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _professionPracticeCertificate(DoctorDetailsModel doctorDetails) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: AppPadding.p5)),
        overlayColor: MaterialStatePropertyAll(ColorManager.lightBlue),
        backgroundColor: MaterialStatePropertyAll(ColorManager.white),
      ),
      onPressed: () {},
      child: Row(
        children: [
          Icon(
            Icons.image_aspect_ratio_outlined,
            color: ColorManager.darkPrimary2,
          ),
          const SizedBox(
            width: AppSize.s10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'profession practice certificate',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: AppSize.s5,
                ),
                Text(
                  'Press to check doctor\'s profession practice certificate to ensure it\'s a real doctor account',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: ColorManager.grey),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: ColorManager.darkPrimary2,
          ),
        ],
      ),
    );
  }

  Widget _dateBar() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: AppPadding.p5,
        horizontal: AppPadding.p5,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.p10,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ColorManager.lightBlue,
        borderRadius: BorderRadius.circular(AppSize.s20),
      ),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        dateTextStyle: Theme.of(context).textTheme.bodySmall!,
        monthTextStyle: Theme.of(context).textTheme.bodySmall!,
        dayTextStyle: Theme.of(context).textTheme.bodySmall!,
        selectedTextColor: Colors.white,
        selectionColor: ColorManager.error,
        onDateChange: (selectedDate) {
          _viewModel.pickDate(selectedDate);
        },
        locale: "en",
      ),
    );
  }

  Widget _doctorSchedules(DoctorDetailsModel? doctorDetails) {
    return StreamBuilder<bool>(
        stream: _viewModel.outputIsPickedDate,
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            if (doctorDetails?.schedules == null ||
                (doctorDetails?.schedules?.isEmpty).orFalse()) {
              return Center(
                child: Text(
                  'Doctor doesn\'t add any schedules yet',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: ColorManager.error),
                ),
              );
            } else {
              final matchingSchedules = doctorDetails?.schedules
                  ?.where((schedule) =>
                      schedule.weekDayNUmber == _viewModel.selectedDate.weekday)
                  .toList();

              if ((matchingSchedules?.isEmpty).orFalse()) {
                return Center(
                  child: Text(
                    'No work for this day',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: ColorManager.error),
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (matchingSchedules?.length).orZero(),
                  itemBuilder: (context, index) {
                    return scheduleItem(matchingSchedules, index);
                  },
                );
              }
            }
          } else {
            return Container();
          }
        });
  }

  Widget scheduleItem(List<DoctorScheduleModel>? schedules, int index) {
    String fromTimeStr =
        '${(schedules?[index].fromHr).orZero()}:${(schedules?[index].fromMin).orZero()}';
    DateTime fromTimeDate = DateFormat('H:m').parse(fromTimeStr);
    String formattedTimeFrom = DateFormat('h:mm a').format(fromTimeDate);

    print(formattedTimeFrom);

    String toTimeStr =
        '${(schedules?[index].toHr).orZero()}:${(schedules?[index].toMin).orZero()}';
    DateTime toTimeDate = DateFormat('H:m').parse(toTimeStr);
    String formattedTimeTo = DateFormat('h:mm a').format(toTimeDate);

    print(formattedTimeTo);

    return Container(
      width: 150,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(
        left: AppMargin.m20,
        right: AppMargin.m20,
        bottom: AppMargin.m10,
      ),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
            width: double.infinity,
            color: ColorManager.darkPrimary2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(formattedTimeFrom),
                const Text('to'),
                Text(formattedTimeTo),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              _viewModel.addReservation(
                await _appPreferences.getUserId(),
                widget.doctorId,
                (schedules?[index].id).orEmpty(),
                DateFormat('yyyy-MM-dd').format(_viewModel.selectedDate),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p5),
              margin: const EdgeInsets.only(top: AppPadding.p10),
              alignment: Alignment.center,
              width: double.infinity,
              color: ColorManager.error,
              child: const Text('Book'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reservationRequiredText() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Text(
            'Reservation required, first come first served.',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p60),
          child: Divider(
            thickness: 5,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
