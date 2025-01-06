import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/features/splash/presentation/pages/welcome.view.dart';

import '../../../../core/params/colors.dart';
import '../../../home/presentation/pages/page_wrapper.view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  Future<void> _navigateToNextPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstTime = prefs.getBool('isFirstTime');

    await Future.delayed(const Duration(seconds: 3));

    if (isFirstTime == null || isFirstTime == true) {
      Navigator.pushReplacementNamed(context, WelcomePage.routeName);
    } else {
      Navigator.pushReplacementNamed(context, PageWrapper.routeName);
      // Navigator.pushReplacementNamed(context, OrderDetailsPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text(
            "Splash Screen",
            style: TextStyle(color: MyColors.primaryColor, fontWeight: FontWeight.w800, fontSize: 40),
          ),
        ),
      ),
    );
  }
}
