import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doctor_application/app/app_prefs.dart';
import 'package:doctor_application/app/di.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/routes_manager.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return _buildBody(context, size);
  }

  _buildBody(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p30),
      child: Column(
        children: [
          _item(
              icon: FontAwesomeIcons.userPen,
              title: AppStrings.profile,
              onTap: () {
                Navigator.pushNamed(context, Routes.profileRoute);
              }),
          const Divider(
            thickness: AppSize.s4,
          ),
          _item(
              icon: FontAwesomeIcons.language,
              title: AppStrings.language,
              onTap: () {}),
          const Divider(
            thickness: AppSize.s4,
          ),
          _item(
            icon: FontAwesomeIcons.arrowRightFromBracket,
            title: AppStrings.logout,
            onTap: () {
              _logout();
            },
          ),
        ],
      ),
    );
  }

  _item({
    required IconData icon,
    required String title,
    required Function() onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: AppSize.s50,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: ColorManager.primary,
                ),
                const SizedBox(width: AppSize.s30),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _logout() {

       _appPreferences.logout();

      Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.authRoute,
          ModalRoute.withName(Routes.splashRoute),
        );

  }
}
