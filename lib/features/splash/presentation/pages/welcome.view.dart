import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store/features/auth/presentation/pages/register.view.dart';

import '../../../../core/params/colors.dart';
import '../../../../core/params/text_styles.dart';
import '../../../../core/widgets/spacer.widget.dart';
import '../../../home/presentation/pages/page_wrapper.view.dart';

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
        color: MyColors.primaryColor,
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
                                 Text(
                                  "Welcome to Grocery Shop 1",
                                  textAlign: TextAlign.justify,
                                  style: MyTextStyles.header.copyWith(color: Colors.white),
                                ),
                                SpacerV(20),
                                 Text(
                                  "Emdark on a culdry journery whit fresh ingegment brouth right in your tulchain.",
                                  textAlign: TextAlign.center,
                                  style: MyTextStyles.caption.copyWith(color: Colors.white54),
                                  /*style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 20,
                                  ),*/
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                 Text(
                                  "Welcome to Grocery Shop 2",
                                  textAlign: TextAlign.justify,
                                    style: MyTextStyles.header.copyWith(color: Colors.white),

                                ),
                                SpacerV(20),
                                 Text(
                                  "Emdark on a culdry journery whit fresh ingegment brouth right in your tulchain.",
                                  textAlign: TextAlign.center,
                                  style: MyTextStyles.caption.copyWith(color: Colors.white54),
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                 Text(
                                  "Welcome to Grocery Shop 3",
                                  textAlign: TextAlign.justify,
                                  style: MyTextStyles.header.copyWith(color: Colors.white),
                                ),
                                SpacerV(20),
                                 Text(
                                  "Emdark on a culdry journery whit fresh ingegment brouth right in your tulchain.",
                                  textAlign: TextAlign.center,
                                   style: MyTextStyles.caption.copyWith(color: Colors.white54),
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
                          Navigator.pushReplacementNamed(context, RegisterPage.routeName);
                          // Navigator.pushReplacementNamed(context, PageWrapper.routeName);
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
                        child:  Text(
                          'Continue',
                          style: MyTextStyles.button.copyWith(color: MyColors.primaryColor), //TextStyles.),
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
