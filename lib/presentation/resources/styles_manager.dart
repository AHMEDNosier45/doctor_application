import 'package:flutter/material.dart';
import 'package:doctor_application/presentation/resources/font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color)
{
  return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight);
}

// regular style

TextStyle getRegularStyle({double fontSize = FontSize.s12, required Color color})
{
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

// medium style

TextStyle getMediumStyle({double fontSize = FontSize.s12, required Color color})
{
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

// semiBold style

TextStyle getSemiBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}

// bold style

TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color})
{
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}
