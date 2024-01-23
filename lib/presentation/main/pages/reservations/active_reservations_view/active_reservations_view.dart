import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:doctor_application/app/app_prefs.dart';
import 'package:doctor_application/app/di.dart';
import 'package:doctor_application/app/extensions.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:doctor_application/presentation/main/pages/reservations/active_reservations_view/active_reservations_view_model.dart';
import 'package:doctor_application/presentation/resources/assets_manager.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/font_manager.dart';
import 'package:doctor_application/presentation/resources/routes_manager.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';

class ActiveReservationsView extends StatefulWidget {
  // final String patientId;
  const ActiveReservationsView({Key? key}) : super(key: key);

  @override
  State<ActiveReservationsView> createState() => _ActiveReservationsViewState();
}

class _ActiveReservationsViewState extends State<ActiveReservationsView> {
  final ActiveReservationsViewModel _viewModel =
      instance<ActiveReservationsViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() async {
    print(await _appPreferences.getUserId());
    _viewModel.patientId = await _appPreferences.getUserId();
    _viewModel.start();
    _viewModel.isDoneStreamController.listen((isDone) {
      if(isDone){
        dismissDialog(context);
      }
    });
    _viewModel.isCanceledStreamController.listen((isCanceled) {
      if(isCanceled){
        dismissDialog(context);
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
    return Column(
      children: [
        _head(),
        Expanded(
          child: StreamBuilder<FlowState>(
            stream: _viewModel.outPutState,
            builder: (context, snapshot) {
              return snapshot.data?.getScreenWidget(context,
                      contentScreenWidget: _getContentWidget(),
                      retryActionFunction: () {
                    _viewModel.start();
                  }, buttonTitle: AppStrings.retryAgain) ??
                  LoadingState(
                          stateRendererType:
                              StateRendererType.fullScreenLoadingState)
                      .getScreenWidget(context);
            },
          ),
        ),
      ],
    );
  }

  Widget _head() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p20, vertical: AppPadding.p10),
          child: Text(
            'Reservation required, first come first served.',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: AppPadding.p60,
            right: AppPadding.p60,
            bottom: AppPadding.p10,
          ),
          child: Divider(
            thickness: 5,
          ),
        ),
      ],
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<ReservationsViewObject>(
      stream: _viewModel.outputReservations,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          List<ReservationModel> reservations = snapshot.data!.reservations;
          if (reservations.isNotEmpty) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: reservations.length,
              itemBuilder: (context, index) =>
                  reservationItem(index, reservations),
            );
          } else {
            return Center(
              child: Text(
                'No reservations yet',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            );
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget reservationItem(int index, List<ReservationModel> reservations) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: AppPadding.p5,
        horizontal: AppPadding.p10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: AppPadding.p10,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ColorManager.lightBlue,
        borderRadius: BorderRadius.circular(AppSize.s20),
      ),
      child: Column(
        children: [
          doctorDetailsSection(index, reservations),
          const SizedBox(
            height: 20,
          ),
          reservationDateSection(index, reservations),
          const SizedBox(
            height: 10,
          ),
          _buttonsSection(index, reservations),
        ],
      ),
    );
  }

  Widget _buttonsSection(int index, List<ReservationModel> reservations) {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _cancelButton(reservations[index].id),
          _rescheduleButton(index, reservations),
        ],
      ),
    );
  }

  Widget _cancelButton(String reservationId) {
    return InkWell(
      overlayColor: MaterialStatePropertyAll(ColorManager.lightBlue),
      borderRadius: BorderRadius.circular(50),
      onTap: () => _viewModel.cancelReservation(reservationId),
      child: Container(
        width: 120,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(
          top: AppPadding.p10,
          bottom: AppPadding.p10,
        ),
        decoration: BoxDecoration(
            border: Border.all(color: ColorManager.darkPrimary1),
            borderRadius: BorderRadius.circular(50),),
        child: Text(
          'Cancel',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: ColorManager.darkPrimary1, fontSize: FontSize.s10),
        ),
      ),
    );
  }

  Widget _rescheduleButton(int index, List<ReservationModel> reservations) {

    String fromTimeStr =
        '${(reservations[index].schedule?.fromHr).orZero()}:${(reservations[index].schedule?.fromMin).orZero()}';
    DateTime fromTimeDate = DateFormat('H:m').parse(fromTimeStr);
    String formattedTimeFrom = DateFormat('h:mm a').format(fromTimeDate);

    print(formattedTimeFrom);

    String toTimeStr =
        '${(reservations[index].schedule?.toHr).orZero()}:${(reservations[index].schedule?.toMin).orZero()}';
    DateTime toTimeDate = DateFormat('H:m').parse(toTimeStr);
    String formattedTimeTo = DateFormat('h:mm a').format(toTimeDate);

    print(formattedTimeTo);

    String dateStr =
    (reservations[index].date.toString().split('T')[0]).orEmpty();
    DateTime date = DateTime.parse(dateStr);
    String formattedDate = DateFormat('dd MMMM yyyy').format(date);

    print(formattedDate);


    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => Navigator.pushNamed(context, Routes.rescheduleReservationRoute,
          arguments: {
        'doctorId': reservations[index].doctor?.id ?? '',
        'reservationId': reservations[index].id,
        'currentDate': date,
        'currentSchedule': '$formattedDate from $formattedTimeFrom to $formattedTimeTo',
          }),
      child: Container(
        width: 120,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(
          top: AppPadding.p10,
          bottom: AppPadding.p10,
        ),
        decoration: BoxDecoration(
            color: ColorManager.darkPrimary1,
            borderRadius: BorderRadius.circular(50),),
        child: Text(
          'Reschedule',
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: ColorManager.white, fontSize: FontSize.s10),
        ),
      ),
    );
  }

  Widget doctorDetailsSection(int index, List<ReservationModel> reservations) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.doctorDetailsRoute,
          arguments: reservations[index].doctor?.id ?? ''),
      child: Row(
        children: [
          // Image.asset(
          //   ImageAssets.doctor,
          //   fit: BoxFit.cover,
          // ),
          const CircleAvatar(
            radius: AppSize.s30,
            backgroundImage: AssetImage(ImageAssets.doctor),
          ),
          const SizedBox(
            width: AppSize.s10,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dr: ${(reservations[index].doctor?.name).orEmpty()}',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: FontSize.s16),
              ),
              Text(
                (reservations[index].doctor?.department?.name).orEmpty(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: ColorManager.grey),
              ),
              // const SizedBox(height: AppSize.s5,),
              // Row(
              //   children: [
              //     Icon(
              //       Icons.location_on_outlined,
              //       color: ColorManager.darkPrimary2,
              //     ),
              //     const SizedBox(
              //       width: AppSize.s10,
              //     ),
              //     Text(
              //       (reservations[index].doctor?.address).orEmpty().toString(),
              //       style: Theme.of(context).textTheme.bodySmall,
              //     ),
              //   ],
              // ),
              // const SizedBox(height: AppSize.s5,),
              // Row(
              //   children: [
              //     Icon(
              //       Icons.attach_money_outlined,
              //       color: ColorManager.darkPrimary2,
              //     ),
              //     const SizedBox(
              //       width: AppSize.s10,
              //     ),
              //     Text(
              //       (reservations[index].doctor?.fee).toString(),
              //       style: Theme.of(context).textTheme.bodySmall,
              //     ),
              //   ],
              // ),
            ],
          ),
          const Spacer(),
          PopupMenuButton<String>(
            onSelected: (String value) {
              // يتم استدعاء هذه الدالة عندما يتم اختيار خيار من القائمة المنبثقة
              switch (value) {
                case 'option1':
                  _viewModel.doneReservation(reservations[index].id);
                // يتم تنفيذ اختيار الخيار الأول
                  break;
                // case 'option2':
                // // يتم تنفيذ اختيار الخيار الثاني
                //   break;
                // case 'option3':
                // // يتم تنفيذ اختيار الخيار الثالث
                //   break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'option1',
                height: 20,
                child: Center(child: Text('Done',style: Theme.of(context).textTheme.labelMedium,)),
              ),
              // const PopupMenuItem<String>(
              //   value: 'option2',
              //   child: Text('Option 2'),
              // ),
              // const PopupMenuItem<String>(
              //   value: 'option3',
              //   child: Text('Option 3'),
              // ),
            ],
            child: const Icon(Icons.more_vert_outlined),
          )
        ],
      ),
    );
  }

  Widget reservationDateSection(int index, List<ReservationModel> reservations) {
    String fromTimeStr =
        '${(reservations[index].schedule?.fromHr).orZero()}:${(reservations[index].schedule?.fromMin).orZero()}';
    DateTime fromTimeDate = DateFormat('H:m').parse(fromTimeStr);
    String formattedTimeFrom = DateFormat('h:mm a').format(fromTimeDate);

    print(formattedTimeFrom);

    String toTimeStr =
        '${(reservations[index].schedule?.toHr).orZero()}:${(reservations[index].schedule?.toMin).orZero()}';
    DateTime toTimeDate = DateFormat('H:m').parse(toTimeStr);
    String formattedTimeTo = DateFormat('h:mm a').format(toTimeDate);

    print(formattedTimeTo);

    String dateStr =
    (reservations[index].date.toString().split('T')[0]).orEmpty();
    DateTime date = DateTime.parse(dateStr);
    String formattedDate = DateFormat('dd MMMM yyyy').format(date);

    print(formattedDate);

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p10, vertical: AppPadding.p5),
      decoration: BoxDecoration(
          color: ColorManager.white.withOpacity(.4),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                size: 15,
              ),
              Text(
                ' $formattedDate',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: ColorManager.grey, fontSize: FontSize.s12),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.access_time_outlined,
                size: 15,
              ),
              Text(
                ' $formattedTimeFrom to $formattedTimeTo',
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
    );
  }
}
