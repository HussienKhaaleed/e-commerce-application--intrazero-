import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intrazero/core/routers/customNavigate.dart';
import 'package:intrazero/features/Cart/Button_Widget.dart';

class SucssesfulScreen extends StatefulWidget {
  const SucssesfulScreen({super.key});

  @override
  State<SucssesfulScreen> createState() => _SucssesfulScreenState();
}

class _SucssesfulScreenState extends State<SucssesfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congratulations!\n Your order is complete!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF2A4BA0),
                  fontSize: 32.sp,
                  fontFamily: 'Lobster',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 100.h,
            ),
            ButtonWidget(
              height: 50.h,
              width: 345.w,
              text: ' Go to Home',
              backgroundColor: Color(0xFF2A4BA0),
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              fontColor: Colors.white,
              onPressed: () async {
                customReplacementNavigate(context, '/home');
              },
            )
          ],
        ),
      ),
    );
  }
}
