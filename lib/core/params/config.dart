/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/core/params/text_styles.dart';
import 'package:wallpaper_changer/core/utils/text_styles.dart';
import 'package:logger/logger.dart';

Logger logger = Logger(
  printer: PrettyPrinter(
    // methodCount: 0, // تعداد خطوط stack trace. صفر برای عدم نمایش.
    errorMethodCount: 0, // تعداد خطوط stack trace برای خطاها.
    lineLength: 100, // طول هر خط لاگ
    // colors: false, // غیرفعال‌سازی رنگ‌ها
    printEmojis: false, // نمایش یا عدم نمایش ایموجی‌ها
    printTime: true, // نمایش زمان
  ),
);

class Config {

  Config._();

  static ThemeData primaryThemeData = ThemeData(
      primarySwatch: Colors.green,
      fontFamily: 'Nexa',
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8)),
          focusColor: Colors.black,
          iconColor: Colors.grey,
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(8)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      appBarTheme: const AppBarTheme(
          toolbarHeight: 69,
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black, size: 24),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: MyTextStyles.appbar));

  static void errorHandler({String title = '', String message = ''}) {
    Get.snackbar(title, message,
        backgroundColor: Colors.grey.shade200, colorText: Colors.black, duration: const Duration(seconds: 4));
  }
}
*/
