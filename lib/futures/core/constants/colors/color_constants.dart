import 'package:flutter/material.dart';

class ColorConstant {
  static final ColorConstant _instance = ColorConstant._init();
  static ColorConstant get instance => _instance;
  ColorConstant._init();
  Color white = const Color(0xF0F0F0F0);
  Color green = const Color(0xFF4AA081);
  Color darkGreen = const Color.fromARGB(76, 74, 160, 128);
  Color transparentGreen = const Color.fromARGB(31, 74, 160, 128);
  Color darkGrey = const Color(0xFF4A4A4A);
  Color grey = Color.fromARGB(255, 136, 136, 136);

  Color textFormFieldColor = const Color(0xFF262626);
  Color black = const Color(0xFF000000);
  Color darkThemeBlack = const Color(0xFF2D292D);
  Color darkThemeAppBar = const Color(0xFF635F63);
  Color transparent = Colors.transparent;
  Color blackTransparent = const Color.fromARGB(13, 0, 0, 0);

  Color fullTransparent = const Color.fromARGB(0, 0, 0, 0);
}
