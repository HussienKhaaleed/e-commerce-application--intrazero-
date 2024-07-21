class UserAuthenticationState {}

final class UserAuthenticationInitial extends UserAuthenticationState {}

final class SignupLoadingState extends UserAuthenticationState {}

final class SignupSucessState extends UserAuthenticationState {}

final class SignupFailureState extends UserAuthenticationState {
  final String errMessage;

  SignupFailureState({required this.errMessage});
}

final class SignInLoadingState extends UserAuthenticationState {}

final class SignInSucessState extends UserAuthenticationState {}

final class SignInFailureState extends UserAuthenticationState {
  final String errMessage;

  SignInFailureState({required this.errMessage});
}

final class ResetPasswordLoadingState extends UserAuthenticationState {}

final class ResetPasswordSuccessState extends UserAuthenticationState {}

final class ResetPasswordFailureState extends UserAuthenticationState {
  final String errMessage;

  ResetPasswordFailureState({required this.errMessage});
}
