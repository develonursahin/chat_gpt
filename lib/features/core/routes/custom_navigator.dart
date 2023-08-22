import 'package:flutter/material.dart';

class CustomNavigator {
  static Future goToScreen(BuildContext context, Widget screen) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
