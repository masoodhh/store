import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:store/core/components/buttons/primary_button.dart';
import 'package:store/core/params/text_styles.dart';
import 'package:store/features/auth/presentation/pages/login.view.dart';

import '../../../../core/components/buttons/lincke_button.dart';
import '../../../../core/components/textfields/primary_textfield.dart';
import '../../../../core/params/colors.dart';
import '../../../../core/widgets/spacer.widget.dart';
import '../../../home/presentation/pages/page_wrapper.view.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const routeName = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

//TODO: registerPage رو ساختم فقط مونده استفاده ازش احتمالا باید یک تب تنظیماتی چیزی برای این درست کنم
class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: MyColors.primaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Register Now",
                style: MyTextStyles.header,
              ),
              const Text(
                "Sign up with your email and password to register",
                style: MyTextStyles.caption,
              ),
              const SizedBox(height: 40),
              const PrimaryTextfield(
                prefixIcon: Icons.email_outlined,
                hint: "Email Address",
              ),
              SpacerV(20),
              const PrimaryTextfield(
                prefixIcon: Icons.lock_outline,
                hint: "Password",
                isPassword: true,
              ),
              SpacerV(20),
              const PrimaryTextfield(
                prefixIcon: Icons.lock_outline,
                hint: "Confirm Password",
                isPassword: true,
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                title: "Sign In",
                onPressed: () => Navigator.pushReplacementNamed(context, PageWrapper.routeName),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(child: Container(color: Colors.grey, height: 1)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Or Continue With",
                      style: MyTextStyles.caption,
                    ),
                  ),
                  Expanded(child: Container(color: Colors.grey, height: 1))
                ],
              ),
              SpacerV(20),
              LinkButton(
                  title: "Continue with Google",
                  prefixWidget: const Icon(
                    Icons.g_mobiledata,
                    size: 40,
                  ),
                  onPressed: () {}),
              SpacerV(20),
              LinkButton(
                  title: "Continue with Apple",
                  prefixWidget: const Icon(
                    Icons.apple,
                    size: 35,
                  ),
                  onPressed: () {}),
              SpacerV(20),
              Center(
                child: RichText(
                    text: TextSpan(
                        text: "Already have an account? ",
                        style: MyTextStyles.caption,
                        children: [
                      TextSpan(
                        text: "Sign In",
                        style: MyTextStyles.button.copyWith(color: MyColors.primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(context, LoginPage.routeName);
                          },
                      ),
                    ])),
              )
            ],
          ),
        ),
      ),
    ));
  }

}
