import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:doctor_application/app/app_prefs.dart';
import 'package:doctor_application/app/di.dart';
import 'package:doctor_application/app/extensions.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:doctor_application/presentation/main/pages/reservations/done_reservations/done_reservations_view_model.dart';
import 'package:doctor_application/presentation/resources/assets_manager.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/font_manager.dart';
import 'package:doctor_application/presentation/resources/routes_manager.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';

class DoneReservationsView extends StatefulWidget {
  // final String patientId;
  const DoneReservationsView({Key? key}) : super(key: key);

  @override
  State<DoneReservationsView> createState() => _DoneReservationsViewState();
}

class _DoneReservationsViewState extends State<DoneReservationsView> {
  final DoneReservationsViewModel _viewModel = instance<DoneReservationsViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() async {
    print(await _appPreferences.getUserId());
    _viewModel.patientId = await _appPreferences.getUserId();
    _viewModel.start();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void setState(VoidCallback fn) {
    if(mounted){
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
                      stateRendererType: StateRendererType.fullScreenLoadingState)
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
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20,vertical: AppPadding.p10),
          child: Text(
            'To rebook, click on doctor name and pick a date.',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: AppPadding.p60,
            right: AppPadding.p60,
            bottom: AppPadding.p10,
          ),
          child: Divider(thickness: 5,),
        ),
      ],
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<DoneReservationsViewObject>(
      stream: _viewModel.outputReservations,
      builder: (context, snapshot) {
        if(snapshot.data != null) {
          List<ReservationModel> reservations = snapshot.data!.doneReservations;
          if (reservations.isNotEmpty) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: reservations.length,
              itemBuilder: (context, index) =>
                  reservationItem(index, reservations),
            );
          } else {
            return Center(child: Text(
              'No reservations yet',
              style: Theme
                  .of(context)
                  .textTheme
                  .labelLarge,
            ),);
          }
        }
        else {
          return Container();
        }
      },
    );
  }

  Widget reservationItem(int index, List<ReservationModel> reservations) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: AppPadding.p5,horizontal: AppPadding.p10,),
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
          const SizedBox(height: 20,),
          reservationDateSection(index, reservations),
        ],
      ),
    );
  }

  Widget _buttonsSection(String reservationId){
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _updateButton(),
          _cancelButton(reservationId),
        ],
      ),
    );
  }

  Widget _cancelButton(String reservationId){
    return InkWell(
      onTap: () => _viewModel.cancelReservation(reservationId),
      child: Container(
        padding: const EdgeInsets.only(
          right: AppPadding.p10,
          top: AppPadding.p5,
          bottom: AppPadding.p5,
          left: AppPadding.p5,
        ),
        decoration: BoxDecoration(
            border: Border.all(
                color: ColorManager.error
            ),
            borderRadius: BorderRadius.circular(50)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cancel_outlined,
              color: ColorManager.error,
            ),
            const SizedBox(
              width: AppSize.s5,
            ),
            Text(
              'Cancel',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: ColorManager.error),
            ),
          ],
        ),
      ),
    );
  }

  Widget _updateButton(){
    return Container(
      padding: const EdgeInsets.only(right: AppPadding.p10,
        top: AppPadding.p5,
        bottom: AppPadding.p5,
        left: AppPadding.p5,),
      decoration: BoxDecoration(
          border: Border.all(
              color: ColorManager.primary
          ),
          borderRadius: BorderRadius.circular(50)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.update_outlined,
            color: ColorManager.primary,
          ),
          const SizedBox(
            width: AppSize.s5,
          ),
          Text(
            'Update',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: ColorManager.primary),
          ),
        ],
      ),
    );
  }

  Widget reservationDateSection(int index, List<ReservationModel> reservations) {

    String fromTimeStr = '${(reservations[index].schedule?.fromHr).orZero()}:${(reservations[index].schedule?.fromMin).orZero()}';
    DateTime fromTimeDate = DateFormat('H:m').parse(fromTimeStr);
    String formattedTimeFrom = DateFormat('h:mm a').format(fromTimeDate);

    print(formattedTimeFrom);


    String toTimeStr = '${(reservations[index].schedule?.toHr).orZero()}:${(reservations[index].schedule?.toMin).orZero()}';
    DateTime toTimeDate = DateFormat('H:m').parse(toTimeStr);
    String formattedTimeTo = DateFormat('h:mm a').format(toTimeDate);

    print(formattedTimeTo);


    String dateStr = (reservations[index].date.toString().split('T')[0]).orEmpty();
    DateTime date = DateTime.parse(dateStr);
    String formattedDate = DateFormat('dd MMMM yyyy').format(date);

    print(formattedDate);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10,vertical: AppPadding.p5),
      decoration: BoxDecoration(
          color: ColorManager.white.withOpacity(.3),
          borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.calendar_month_outlined,size: 15,),
              Text(' $formattedDate', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorManager.grey,fontSize: FontSize.s12),),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.access_time_outlined,size: 15,),
              Text(' $formattedTimeFrom to $formattedTimeTo', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorManager.grey,fontSize: FontSize.s12),),
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

  Widget doctorDetailsSection(int index, List<ReservationModel> reservations) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.doctorDetailsRoute,arguments: reservations[index].doctor?.id??''),
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
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorManager.grey),
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
        ],
      ),
    );
  }
}
