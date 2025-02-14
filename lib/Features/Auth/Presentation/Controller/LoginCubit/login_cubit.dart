import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/Features/Auth/Data/Repository/repository.dart';
import 'package:weatherapp/Features/Auth/Data/user_model/user_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginInitial());
  static LoginCubit get(context)=> BlocProvider.of(context);

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(LoginLoading());
    try {
      final user = await _authRepository.signInWithEmailAndPassword(email, password);
      if (user != null) {
        emit(LoginSuccess(user: user));
      } else {
        emit(LoginFailure(message: "Login failed. Please try again."));
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(message: _getErrorMessage(e.code)));
    } catch (e) {
      emit(LoginFailure(message: "An unexpected error occurred."));
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'invalid-credential':
        return "Email or Password May Be Wrong";
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

