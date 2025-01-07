import 'package:flutter/material.dart';

import 'colors.dart';

class MyTextStyles {
  MyTextStyles._();

  static const header = TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: MyColors.primaryColor);
  static const header2 = TextStyle(fontSize: 23, fontWeight: FontWeight.bold,color: MyColors.primaryColor);
  static const header3 = TextStyle(fontSize: 17, fontWeight: FontWeight.w600,color: MyColors.primaryColor);

  static const caption = TextStyle(fontSize: 20, fontWeight: FontWeight.normal,color: MyColors.primaryColor);
  static const button = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  static const appbar = TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black);
  static const textField = TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.black);

  static const small = TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey);
  static const headline = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey);
  static const title = TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black);

  static const chat = TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white);
}
