import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextfield extends StatelessWidget {
  final String? hint;
  final IconData? prefixIcon;
  final bool? isPassword;
  final int? maxLength;
  final TextEditingController? controller;
  final bool multiLine;
  final bool isNumber;
  final Function(String)? onChanged;

  const PrimaryTextfield({
    Key? key,
    this.hint,
    this.prefixIcon,
    this.isPassword,
    this.maxLength,
    this.onChanged,
    this.multiLine = false,
    this.isNumber = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: multiLine ? null : 70,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(35),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null)
            Icon(
              prefixIcon,
              color: Colors.grey,
              size: 35,
            ),
          Expanded(
            child: TextField(
              controller: controller,
              maxLength: multiLine ? null : (maxLength ?? 100),
              onChanged: onChanged,
              style: TextStyle(fontSize: 16, color: Colors.black), // جایگزین MyTextStyles.caption
              maxLines: multiLine ? null : 1,
              minLines: multiLine ? 3 : 1,
              obscureText: isPassword ?? false,
              keyboardType: isNumber ? TextInputType.number : TextInputType.text,
              inputFormatters: isNumber
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : null,
              decoration: InputDecoration(
                counterText: '',
                contentPadding: const EdgeInsets.all(10),
                hintText: hint ?? '',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
