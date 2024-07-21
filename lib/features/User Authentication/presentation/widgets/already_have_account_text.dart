import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class already_have_account_text extends StatelessWidget {
  final VoidCallback onTap;
  final String fristText;
  final String secondText;
  const already_have_account_text(
      {super.key,
      required this.onTap,
      required this.fristText,
      required this.secondText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: fristText,
              style: TextStyle(
                fontSize: 13.sp,
                color: Color.fromARGB(239, 18, 5, 100),
              ),
            ),
            TextSpan(
              text: secondText,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2A4BA0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
