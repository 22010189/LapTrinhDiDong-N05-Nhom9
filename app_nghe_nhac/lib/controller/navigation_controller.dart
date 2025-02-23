import 'package:flutter/material.dart';

class NavigationController {
  static void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
