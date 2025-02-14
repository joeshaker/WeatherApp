part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}
class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final UserModel user;

  SignupSuccess({required this.user});
}

class SignupFailure extends SignupState {
  final String message;

  SignupFailure({required this.message});
}
final class ChangePasswordVisibilityState extends SignupState {}