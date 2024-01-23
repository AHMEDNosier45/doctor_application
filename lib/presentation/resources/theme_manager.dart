import 'package:flutter/material.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/font_manager.dart';
import 'package:doctor_application/presentation/resources/styles_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';

class ThemeManager {
  static ThemeData getApplicationTheme() {
    return ThemeData(
      // main colors

      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightPrimary,
      primaryColorDark: ColorManager.darkPrimary2,
      disabledColor: ColorManager.grey,

      //Date Picker

      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: ColorManager.darkPrimary1,
        onPrimary: ColorManager.white,
        secondary: ColorManager.darkPrimary2,
        onSecondary: ColorManager.darkPrimary2,
        error: ColorManager.error,
        onError: ColorManager.error,
        background: ColorManager.white,
        onBackground: ColorManager.white,
        surface: ColorManager.darkPrimary1,
        onSurface: ColorManager.darkPrimary1,
      ),

      //main Font

      fontFamily: FontConstants.fontFamily,

      //Button theme

      buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey,
      ),

      // text theme
      textTheme: TextTheme(
        displayLarge:
            getBoldStyle(color: ColorManager.white, fontSize: FontSize.s25),
        headlineLarge:
            getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s22),
        headlineMedium: getMediumStyle(
            color: ColorManager.darkPrimary1, fontSize: FontSize.s20),
        headlineSmall:
            getRegularStyle(color: ColorManager.black, fontSize: FontSize.s18),
        titleLarge: getSemiBoldStyle(
            color: ColorManager.darkPrimary1, fontSize: FontSize.s20),
        titleMedium:
            getMediumStyle(color: ColorManager.white, fontSize: FontSize.s18),
        titleSmall: getRegularStyle(
            color: ColorManager.darkPrimary1, fontSize: FontSize.s16),
        bodyLarge:
            getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s18),
        bodyMedium:
            getMediumStyle(color: ColorManager.white, fontSize: FontSize.s16),
        bodySmall:
            getRegularStyle(color: ColorManager.black, fontSize: FontSize.s14),
        labelLarge: getSemiBoldStyle(
            color: ColorManager.darkPrimary1, fontSize: FontSize.s16),
        labelMedium: getMediumStyle(
            color: ColorManager.darkPrimary1, fontSize: FontSize.s14),
        labelSmall:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s12),
      ),

      // input decoration theme (text form field)

      inputDecorationTheme: InputDecorationTheme(

          // content padding
          contentPadding: const EdgeInsets.all(AppPadding.p12),

          // hint style
          hintStyle: getRegularStyle(
              color: ColorManager.darkPrimary2, fontSize: FontSize.s14),

          // label style
          labelStyle: getMediumStyle(
              color: ColorManager.darkPrimary1, fontSize: FontSize.s14),

          // error style
          errorStyle: getRegularStyle(color: ColorManager.error),

          // enabled border style
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.darkPrimary1, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s30))),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.darkPrimary1, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s30))),

          // focused border style
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.darkPrimary1, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s30))),
          fillColor: ColorManager.darkPrimary1,

          // error border style
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.error, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s30))),

          // focused border style
          focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.error, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s30)))),
    );
  }
}
