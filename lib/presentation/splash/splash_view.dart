
// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:doctor_application/app/app_prefs.dart';
import 'package:doctor_application/app/di.dart';
import 'package:doctor_application/data/network/network_info.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:doctor_application/presentation/resources/assets_manager.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/constants_manager.dart';
import 'package:doctor_application/presentation/resources/routes_manager.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final NetworkInfo _networkInfo = instance<NetworkInfo>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async {
    if (await _networkInfo.isConnected) {
      _appPreferences.isUserLoggedIn().then((isUserLoggedIn) {
        if (isUserLoggedIn) {
          Navigator.pushReplacementNamed(context, Routes.mainRoute,arguments: {
            'pageIndex':0,
          });
        } else {
          _appPreferences
              .isOnBoardingScreenViewed()
              .then((isOnBoardingScreenViewed) {
            if (isOnBoardingScreenViewed) {
              Navigator.pushReplacementNamed(context, Routes.authRoute);
            } else {
              Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
            }
          });
        }
      });
    } else {
      ErrorState(StateRendererType.popupErrorState, AppStrings.noInternetError)
          .getScreenWidget(context, contentScreenWidget: _buildBody(),buttonTitle: AppStrings.retryAgain,
              retryActionFunction: () {
        dismissDialog(context);
        _startDelay();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorManager.primary,
            ColorManager.darkPrimary2,
          ],
        ),
      ),
      child: Center(
        child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(AppSize.s1, AppSize.s7),
                      spreadRadius: 1,
                      color: ColorManager.black,
                      blurRadius: 5),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: ColorManager.darkPrimary1,
                radius: AppSize.s104,
                child: CircleAvatar(
                  backgroundColor: ColorManager.white,
                  radius: AppSize.s100,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset(JsonAssets.loading),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        Text(AppStrings.logo,style: Theme.of(context).textTheme.titleLarge,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
