import 'package:flutter/material.dart';

import '../../params/colors.dart';
import '../../params/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const PrimaryButton({Key? key, required this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 70,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      disabledColor: MyColors.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12.5),
      child: Text(title, style: MyTextStyles.button),
    );
  }
}
