import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:doctor_application/app/di.dart';
import 'package:doctor_application/app/extensions.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:doctor_application/presentation/common/widgets/custom_app_bar.dart';
import 'package:doctor_application/presentation/reschedule_reservation/reschedule_reservation_view_model.dart';
import 'package:doctor_application/presentation/resources/assets_manager.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/font_manager.dart';
import 'package:doctor_application/presentation/resources/routes_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';

class RescheduleReservationView extends StatefulWidget {
  final String doctorId;
  final String reservationId;
  final String currentSchedule;
  final DateTime currentDate;
  const RescheduleReservationView({Key? key, required this.doctorId, required this.reservationId, required this.currentSchedule, required this.currentDate}) : super(key: key);

  @override
  State<RescheduleReservationView> createState() => _RescheduleReservationViewState();
}

class _RescheduleReservationViewState extends State<RescheduleReservationView> {
  final RescheduleReservationViewModel _viewModel = instance<RescheduleReservationViewModel>();
  bool isSchedules = false;

  _bind() {
    _viewModel.doctorId = widget.doctorId;
    _viewModel.start();
    _viewModel.isRescheduledStreamController.listen((isRescheduled) {
      if (isRescheduled) {
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Reschedule Reservation',centerTitle: true,),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outPutState,
        builder: (context, snapshot) {
          if(snapshot.data != null) {
            return snapshot.data!.getScreenWidget(
              context,
              contentScreenWidget: _getContentWidget(size, context),
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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: AppSize.s30,
                backgroundImage: AssetImage(ImageAssets.doctor),
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
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s25,),
          reservationDateSection(),
          const SizedBox(height: AppSize.s10,),
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
        height: AppSize.s100,
        width: AppSize.s80,
        dateTextStyle: Theme.of(context).textTheme.bodySmall!,
        monthTextStyle: Theme.of(context).textTheme.bodySmall!,
        dayTextStyle: Theme.of(context).textTheme.bodySmall!,
        deactivatedColor: ColorManager.primary,
        selectedTextColor: Colors.white,
        selectionColor: ColorManager.error,
        inactiveDates: [
          widget.currentDate
        ],
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
              _viewModel.updateReservation(
                widget.reservationId,
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
              child: const Text('Reschedule'),
            ),
          ),
        ],
      ),
    );
  }

  Widget reservationDateSection() {
    return Row(
      children: [
        Text('Current : ',style: Theme.of(context).textTheme.labelLarge?.copyWith(color: ColorManager.grey,fontSize: FontSize.s12),),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p10, vertical: AppPadding.p5),
          decoration: BoxDecoration(
              color: ColorManager.lightBlue,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 15,
                  ),
                  Text(
                    widget.currentSchedule.split(' from ')[0],
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: ColorManager.grey, fontSize: FontSize.s12),
                  ),
                ],
              ),
              const SizedBox(width: AppSize.s20,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.access_time_outlined,
                    size: 15,
                  ),
                  Text(
                    widget.currentSchedule.split(' from ')[1],
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: ColorManager.grey, fontSize: FontSize.s12),
                  ),
                ],
              ),
            ],
          ),

          // Text.rich(
          //   TextSpan(
          //     children: [
          //       TextSpan(
          //         text: '$formattedDate from $formattedTimeFrom to $formattedTimeTo',
          //         style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorManager.grey,fontSize: FontSize.s12),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ],
    );
  }
}
