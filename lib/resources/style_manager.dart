import 'package:flutter/material.dart';

class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight superBold = FontWeight.w900;
}

TextStyle getTextStyle(FontWeight fontWeight, Color color) {
  return TextStyle(fontWeight: fontWeight, color: color);
}

TextStyle getStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}

TextStyle getTextWeight(FontWeight fontWeight) {
  return TextStyle(fontWeight: fontWeight);
}
