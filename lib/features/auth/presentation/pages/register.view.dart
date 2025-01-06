import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:store/core/components/buttons/primary_button.dart';
import 'package:store/core/params/text_styles.dart';

import '../../../../core/components/buttons/lincke_button.dart';
import '../../../../core/components/textfields/primary_textfield.dart';
import '../../../../core/params/colors.dart';
import '../../../../core/widgets/spacer.widget.dart';


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
          appBar: _buildAppBar(context),
          backgroundColor: MyColors.primaryBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
                  prefixIcon: Icons.person_outline,
                  hint: "Full Name",
                ),
                /*BlocListener<SubjectBloc, SubjectState>(
                  listener: (context, state) {
                    // TODO: implement listener}
                  },
                  child: SpacerV(20),
                ),*/
                const PrimaryTextfield(
                  prefixIcon: Icons.phone_android,
                  hint: "Phone Number",
                ),
                SpacerV(20),
                const PrimaryTextfield(
                  prefixIcon: Icons.calendar_today,
                  hint: "Date of Birth",
                ),
                const SizedBox(height: 40),
                const PrimaryButton(title: "Sign In"),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(child: Container(color: Colors.black, height: 1)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Or Continue With",
                        style: MyTextStyles.caption,
                      ),
                    ),
                    Expanded(child: Container(color: Colors.black, height: 1))
                  ],
                ),
                SpacerV(20),
                LinkButton(
                    title: "Continue with Google",
                    prefixWidget: const Icon(Icons.fmd_good_sharp),
                    onPressed: () {}),
                SpacerV(20),
                LinkButton(
                    title: "Continue with Apple", prefixWidget: const Icon(Icons.apple), onPressed: () {}),
                SpacerV(20),
                Center(
                  child: RichText(
                      text: TextSpan(
                          text: "Already have an account? ", style: MyTextStyles.caption, children: [
                        TextSpan(
                          text: "Sign In",
                          style: MyTextStyles.button.copyWith(color: MyColors.primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {},
                        ),
                      ])),
                )
              ],
            ),
          ),
        ));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 110,
      backgroundColor: MyColors.primaryBackgroundColor,
      leadingWidth: 70,
      leading: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey.shade200),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: MyColors.primaryColor, size: 25),
        ),
      ),
    );
  }
}
