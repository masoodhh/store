import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store/features/home_page/presentation/pages/page_wrapper.view.dart';

import '../core/params/colors.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  static const routeName = '/welcome';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);

    super.initState();
  }

  Future<void> _changePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:  MyColors.primaryColor,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: Image.asset(
                  'lib/assets/images/fruit/gilas.png',
                  fit: BoxFit.cover,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                        height: 80,
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: 3,
                          effect: const ExpandingDotsEffect(dotColor: Colors.white),
                          onDotClicked: (index) => _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                        )),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  "Welcome to Grocery Shop 1",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Emdark on a culdry journery whit fresh ingegment brouth right in your tulchain.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 20,
                                  ),
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  "Welcome to Grocery Shop 2",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Emdark on a culdry journery whit fresh ingegment brouth right in your tulchain.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 20,
                                  ),
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  "Welcome to Grocery Shop 3",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Emdark on a culdry journery whit fresh ingegment brouth right in your tulchain.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 20,
                                  ),
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (_pageController.page!.round() > 1) {
                          _changePref();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const PageWrapper()),
                          );
                        } else {
                          _pageController.animateToPage(
                            _pageController.page!.round() + 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Container(
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.white),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text(
                          'Continue',
                          style:
                              TextStyle(color: MyColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
