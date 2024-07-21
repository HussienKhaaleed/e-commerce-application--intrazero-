import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class terms_and_conditions_text extends StatelessWidget {
  terms_and_conditions_text({super.key, required this.text});

  String text;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'By $text, you agree to our',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey,
            ),
          ),
          TextSpan(
            text: ' Terms & Conditions',
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color.fromARGB(239, 18, 5, 100),
            ),
          ),
          TextSpan(
            text: ' and',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey,
            ).copyWith(height: 1.5),
          ),
          TextSpan(
            text: ' Privacy Policy',
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color.fromARGB(239, 18, 5, 100),
            ),
          ),
        ],
      ),
    );
  }
}
