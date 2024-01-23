import 'package:flutter/material.dart';
import 'package:doctor_application/presentation/main/pages/reservations/active_reservations_view/active_reservations_view.dart';
import 'package:doctor_application/presentation/main/pages/reservations/canceled_reservations/cancelled_reservations_view.dart';
import 'package:doctor_application/presentation/main/pages/reservations/done_reservations/done_reservations_view.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';

class ReservationsView extends StatefulWidget {
  const ReservationsView({Key? key}) : super(key: key);

  @override
  State<ReservationsView> createState() => _ReservationsViewState();
}

class _ReservationsViewState extends State<ReservationsView> {
  int selectedValue = 0;
  List<String> tapsNames = ['Active','Done','Canceled'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: Column(
          children: [
            _tabBar(),
            _tabView(),
          ],
        ),
      ),
    );
  }

  _tabBar() {
    return TabBar(
      labelPadding: EdgeInsets.zero,
      indicatorColor: Colors.transparent,
      labelColor: ColorManager.white,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      onTap: (value) {
        setState(() {
          selectedValue = value;
        });
      },
      tabs: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: AppPadding.p10,horizontal: AppPadding.p10),
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p5,horizontal: AppPadding.p10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selectedValue == index ? ColorManager.darkPrimary1 : ColorManager.white,
            border: Border.all(
              color: selectedValue == index ? ColorManager.darkPrimary1 : ColorManager.darkPrimary2
            ),
            borderRadius: BorderRadius.circular(AppSize.s30),
            boxShadow: selectedValue == index
                ? [
              BoxShadow(
                color: ColorManager.darkPrimary1,
              ),
            ] : null,
          ),
          child: Text(tapsNames[index], textAlign: TextAlign.center,style: TextStyle(color: selectedValue == index ? ColorManager.white : ColorManager.darkPrimary2),),
        );
      }),
    );
  }

  _tabView() {
    return const Expanded(
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          ActiveReservationsView(),
          DoneReservationsView(),
          CanceledReservationsView(),
        ],
      ),
    );
  }
}
