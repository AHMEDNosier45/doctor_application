import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:doctor_application/presentation/common/widgets/custom_app_bar.dart';
import 'package:doctor_application/presentation/main/pages/home/home_view.dart';
import 'package:doctor_application/presentation/main/pages/reservations/reservations_view.dart';
import 'package:doctor_application/presentation/main/pages/settings/settings_view.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';

class MainView extends StatefulWidget {
  final int pageIndex;
  const MainView({Key? key, required this.pageIndex}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;


  List<Widget> screens = [
    const HomeView(),
    const ReservationsView(),
    // const IssuesView(),
    const SettingsView(),
  ];

  @override
  void initState() {
    currentIndex = widget.pageIndex;
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  List<String> titles = [
    'Departments',
    'Reservations',
    'Settings'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(title: titles[currentIndex]),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: ColorManager.darkPrimary2,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(AppSize.s20),topRight: Radius.circular(AppSize.s20)),
        ),
        height: size.height * .1,
        width: double.infinity,
        child: GNav(
          selectedIndex: currentIndex,
          tabBackgroundGradient: LinearGradient(colors: [ColorManager.primary,ColorManager.darkPrimary2]),
          rippleColor: ColorManager.primary,
          hoverColor: ColorManager.primary,
          haptic: false,
          tabBorderRadius: AppSize.s15,
          tabActiveBorder: Border.all(color: ColorManager.primary),
          gap: size.width * .01,
          color: ColorManager.white,
          activeColor: ColorManager.white,
          iconSize: AppSize.s24,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          padding: const EdgeInsets.all(15),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.table_view,
              text: 'Reservations',
            ),
            // GButton(
            //   icon: Icons.table_rows_rounded,
            //   text: 'Issues',
            // ),
            GButton(
              icon: Icons.settings_outlined,
              text: 'Settings',
            )
          ],
          onTabChange: (value) {
            setState(() {
              currentIndex = value;
            });
          },
        ),
      ),
      body: screens[currentIndex],
    );
  }
}
