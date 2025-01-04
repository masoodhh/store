import 'package:flutter/material.dart';

import '../../params/text_styles.dart';

class LinkButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Icon? prefixWidget;

  const LinkButton({Key? key, required this.title, this.prefixWidget, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(35),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(35),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           if(prefixWidget!=null) Padding(
              padding: EdgeInsets.only(right: 10),
              child: prefixWidget ,
            ),
            Text(
              title,
              style: MyTextStyles.caption,
            ),
          ],
        ),
      ),
    );
  }
}
