import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intrazero/core/routers/customNavigate.dart';
import 'package:intrazero/features/User%20Authentication/presentation/view_model/cubit/user_authentication_cubit.dart';
import 'package:intrazero/features/User%20Authentication/presentation/view_model/cubit/user_authentication_state.dart';
import 'package:intrazero/features/User%20Authentication/presentation/widgets/app_tect_form_field.dart';
import 'package:intrazero/features/User%20Authentication/presentation/widgets/custom_toast.dart';
import 'package:intrazero/features/User%20Authentication/presentation/widgets/text_btn.dart';

class forgetPasswordBody extends StatefulWidget {
  const forgetPasswordBody({super.key});

  @override
  State<forgetPasswordBody> createState() => _forgetPasswordBodyState();
}

class _forgetPasswordBodyState extends State<forgetPasswordBody> {
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    "Forget Password ?",
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Color(0xFF3E4554),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  "Enter your registered email below to receive password reset instruction",
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                BlocConsumer<UserAuthenticationCubit, UserAuthenticationState>(
                  listener: (context, state) {
                    if (state is ResetPasswordSuccessState) {
                      showToast("Check Your Email To Reset Your Password",
                          Colors.white);
                      customReplacementNavigate(context, "/login");
                    } else if (state is ResetPasswordFailureState) {
                      showToast(state.errMessage, Colors.white);
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: formkey,
                      child: Column(
                        children: [
                          textformfield(
                            keyboardType: TextInputType.emailAddress,
                            hintText: "Email",
                            onChanged: (email) {
                              BlocProvider.of<UserAuthenticationCubit>(context)
                                  .emailAddress = email;
                            },
                          ),
                          SizedBox(
                            height: 200.h,
                          ),
                          state is ResetPasswordLoadingState
                              ? const CircularProgressIndicator(
                                  color: Color(0xFF2A4BA0),
                                )
                              : textBtn(
                                  buttonText: "Send Reset Password Link",
                                  textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      await BlocProvider.of<
                                              UserAuthenticationCubit>(context)
                                          .resetPasswordWithLink();
                                    }
                                  },
                                ),
                          SizedBox(
                            height: 16.h,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
