import 'package:flutter/widgets.dart';
import 'package:intrazero/features/User%20Authentication/presentation/widgets/forget_password_body.dart';

class forgetPasswordScreen extends StatefulWidget {
  const forgetPasswordScreen({super.key});

  @override
  State<forgetPasswordScreen> createState() => _forgetPasswordScreenState();
}

class _forgetPasswordScreenState extends State<forgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return forgetPasswordBody();
  }
}
