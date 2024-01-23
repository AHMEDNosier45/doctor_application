import 'package:flutter/material.dart';
import 'package:doctor_application/presentation/authentication/login/login_view.dart';
import 'package:doctor_application/presentation/authentication/register/register_view.dart';
import 'package:doctor_application/presentation/resources/assets_manager.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/constants_manager.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';

class AuthView extends StatefulWidget {

  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: DefaultTabController(
        length: AppConstants.tabLength,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _authHeadWidget(size),
            _tabBar(),
            _tabBarView(size),
          ],
        ),
      ),
    );
  }

  Widget _authHeadWidget(Size size) {
    return Container(
      height: size.height * .25,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorManager.primary, ColorManager.darkPrimary2],
        ),
      ),
      child: Image.asset(ImageAssets.authLogo),
    );
  }

  Widget _tabBar() {
    return Card(
      margin: const EdgeInsets.all(AppMargin.m0),
      elevation: AppSize.s10,
      child: TabBar(
        isScrollable: false,
        indicatorColor: ColorManager.primary,
        tabs: [
          Container(
            height: AppSize.s50,
            alignment: Alignment.center,
            child: Text(
              AppStrings.login,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Container(
            height: AppSize.s50,
            alignment: Alignment.center,
            child: Text(
              AppStrings.register,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBarView(Size size) {
    return const Expanded(
      child: TabBarView(
        children: [
          LoginView(),
          RegisterView(),
        ],
      ),
    );
  }
}
