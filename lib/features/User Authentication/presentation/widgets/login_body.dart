import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intrazero/core/helper/cashe_helper.dart';
import 'package:intrazero/core/routers/customNavigate.dart';
import 'package:intrazero/core/service/service_locter.dart';
import 'package:intrazero/features/User%20Authentication/presentation/view_model/cubit/user_authentication_cubit.dart';
import 'package:intrazero/features/User%20Authentication/presentation/view_model/cubit/user_authentication_state.dart';
import 'package:intrazero/features/User%20Authentication/presentation/widgets/already_have_account_text.dart';
import 'package:intrazero/features/User%20Authentication/presentation/widgets/app_tect_form_field.dart';
import 'package:intrazero/features/User%20Authentication/presentation/widgets/custom_toast.dart';
import 'package:intrazero/features/User%20Authentication/presentation/widgets/terms_and_conditions_text.dart';
import 'package:intrazero/features/User%20Authentication/presentation/widgets/text_btn.dart';

class loginnBody extends StatefulWidget {
  const loginnBody({super.key});

  @override
  State<loginnBody> createState() => _loginnBodyState();
}

class _loginnBodyState extends State<loginnBody> {
  final formkey = GlobalKey<FormState>();
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: const Color(0xFF3E4554),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "We\'re excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in.",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFF3E4554),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
                BlocConsumer<UserAuthenticationCubit, UserAuthenticationState>(
                  listener: (context, state) {
                    if (state is SignInSucessState) {
                      FirebaseAuth.instance.currentUser!.emailVerified
                          ? customReplacementNavigate(context, "/home")
                          : showToast(
                              "Please Verify Your Account", Colors.white);
                      ;
                    } else if (state is SignInFailureState) {
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
                              getIt<CacheHelper>().saveData(
                                key: "Email",
                                value: email,
                              );
                              BlocProvider.of<UserAuthenticationCubit>(context)
                                  .emailAddress = email;
                            },
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          textformfield(
                            keyboardType: TextInputType.visiblePassword,
                            hintText: "Password",
                            onChanged: (password) {
                              BlocProvider.of<UserAuthenticationCubit>(context)
                                  .password = password;
                            },
                            isObscureText: isObscureText,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isObscureText = !isObscureText;
                                });
                              },
                              child: Icon(
                                isObscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Color(0xFF3E4554),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              customNavigate(context, "/forgetpassword");
                            },
                            child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Text(
                                "Forget Password ?",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xFF3E4554),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          state is SignInLoadingState
                              ? const CircularProgressIndicator(
                                  color: Color(0xFF2A4BA0),
                                )
                              : textBtn(
                                  buttonText: "Login",
                                  textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      await BlocProvider.of<
                                              UserAuthenticationCubit>(context)
                                          .signInWithEmailAndPassword();
                                      getIt<CacheHelper>().saveData(
                                        key: "logedIn",
                                        value: true,
                                      );
                                    }
                                  },
                                ),
                          SizedBox(
                            height: 16.h,
                          ),
                          terms_and_conditions_text(
                            text: 'logging',
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          already_have_account_text(
                            onTap: () {
                              customNavigate(context, "/register");
                            },
                            fristText: 'Don’t have an account?',
                            secondText: ' Create An Account',
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
