import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/Features/Auth/Data/Repository/repository.dart';
import 'package:weatherapp/Features/Auth/Data/user_model/user_model.dart';
import 'package:weatherapp/Features/Auth/Presentation/Controller/LoginCubit/login_cubit.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;
  static SignupCubit get(context)=>BlocProvider.of(context);
  SignupCubit(this._authRepository) : super(SignupInitial());
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    emit(SignupLoading());
    try {
      final user = await _authRepository.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        emit(SignupSuccess(user: user));
      } else {
        emit(SignupFailure(message: "Signup failed. Please try again."));
      }
    } on FirebaseAuthException catch (e) {
      emit(SignupFailure(message: _getErrorMessage(e.code)));
    } catch (e) {
      emit(SignupFailure(message: "An unexpected error occurred."));
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return "Password provided is too weak";
      case 'email-already-in-use':
        return "An account already exists";
      default:
        return "An error occurred. Please try again.";
    }
  }
  IconData sufixx=Icons.lock;
  bool isPassword=true;

  void ChangeVisiblity(){
    isPassword=!isPassword;
    sufixx=isPassword?Icons.lock:Icons.lock_open_rounded;
    emit(ChangePasswordVisibilityState());
  }
}
