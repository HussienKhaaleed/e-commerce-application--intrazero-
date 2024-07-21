import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTopText extends StatelessWidget {
  HomeTopText({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    var name;
    if (user != null) {
      final name = user.displayName;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, ${name ?? 'Guest!'}",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              'What are you looking for today?',
              style: TextStyle(fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
