// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intrazero/features/User%20Authentication/presentation/view_model/cubit/user_authentication_state.dart';

class UserAuthenticationCubit extends Cubit<UserAuthenticationState> {
  UserAuthenticationCubit() : super(UserAuthenticationInitial());
  String? Username;
  String? emailAddress;
  String? password;

  Future<void> signUpWithEmailAndPassword() async {
    try {
      emit(SignupLoadingState());
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress!, password: password!);
      await addUserProfile();
      await verifyEmail();
      emit(SignupSucessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
          SignupFailureState(errMessage: 'The password provided is too weak.'),
        );
      } else if (e.code == 'email-already-in-use') {
        emit(
          SignupFailureState(
              errMessage: 'The account already exists for that email.'),
        );
      } else {
        emit(
          SignupFailureState(errMessage: e.code),
        );
      }
    } catch (e) {
      emit(SignupFailureState(errMessage: e.toString()));
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      emit(SignInLoadingState());
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );
      emit(SignInSucessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(
          SignInFailureState(errMessage: 'No user found for that email.'),
        );
      } else if (e.code == 'wrong-password') {
        emit(
          SignInFailureState(
              errMessage: 'Wrong password provided for that user.'),
        );
      } else if (e.code == 'invalid-credential') {
        emit(
          SignInFailureState(
              errMessage: 'Please Enter Valid Email And Password!.'),
        );
      } else {
        emit(
          SignInFailureState(errMessage: e.code),
        );
      }
    }
  }

  Future<void> verifyEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  Future<void> resetPasswordWithLink() async {
    try {
      emit(ResetPasswordLoadingState());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress!);
      emit(ResetPasswordSuccessState());
    } catch (e) {
      emit(ResetPasswordFailureState(errMessage: e.toString()));
    }
  }

  Future<void> addUserProfile() async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    await users.add({
      "email": emailAddress,
      "Username": Username,
    });
  }
}
