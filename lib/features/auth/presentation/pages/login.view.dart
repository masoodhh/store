import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:store/core/components/buttons/primary_button.dart';
import 'package:store/core/params/text_styles.dart';
import 'package:store/features/auth/presentation/pages/register.view.dart';
import 'package:store/features/home/presentation/pages/page_wrapper.view.dart';

import '../../../../core/components/buttons/lincke_button.dart';
import '../../../../core/components/textfields/primary_textfield.dart';
import '../../../../core/params/colors.dart';
import '../../../../core/widgets/spacer.widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  "Welcome Back",
                  style: MyTextStyles.header,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Access your account securely by using your email and password",
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
                SpacerV(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (bool? value) {},
                        ),
                        const Text(
                          "Save Password",
                          style: MyTextStyles.textField,
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot password?",
                        style: MyTextStyles.appbar.copyWith(color: Colors.orange),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                    title: "Sign In",
                    onPressed: () => Navigator.pushReplacementNamed(context, PageWrapper.routeName)),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(child: Container(color: Colors.grey, height: 1)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Or continue with",
                        style: MyTextStyles.caption,
                      ),
                    ),
                    Expanded(child: Container(color: Colors.grey, height: 1))
                  ],
                ),
                SpacerV(20),
                LinkButton(
                  title: "Continue with Google",
                  prefixWidget: const Icon(Icons.g_mobiledata, size: 35),
                  onPressed: () {},
                ),
                SpacerV(20),
                LinkButton(
                  title: "Continue with Apple",
                  prefixWidget: const Icon(Icons.apple, size: 35),
                  onPressed: () {},
                ),
                SpacerV(20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: MyTextStyles.caption,
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style: MyTextStyles.button.copyWith(color: MyColors.primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                               Navigator.pushReplacementNamed(context, RegisterPage.routeName);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
