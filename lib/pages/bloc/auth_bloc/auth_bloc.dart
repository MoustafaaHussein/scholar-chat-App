import 'package:bloc/bloc.dart';
import 'package:chatapp/helper/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          // ignore: unused_local_variable
          UserCredential userData = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'wrong-password') {
            emit(LoginFailure(errorMessage: 'Wrong Passowrd please try again'));
          } else if (ex.code == 'user-not-found') {
            emit(LoginFailure(
                errorMessage:
                    'user not found please register or enter the correct user'));
          } else {
            emit(LoginFailure(errorMessage: '${ex.code}'));
          }
        }
      } else if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          var auth = FirebaseAuth.instance;
          // ignore: unused_local_variable
          UserCredential userData = await auth.createUserWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(RegisterSuccessfully());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'invalid-email') {
            emit(RegisterFailed(
                errorMessage: 'The email address is badly formatted.'));
          } else if (e.code == 'email-already-in-use') {
            emit(RegisterFailed(
                errorMessage: 'The email address is already in use.'));
          } else if (e.code == 'weak-password') {
            emit(RegisterFailed(errorMessage: 'The password is too weak.'));
          } else if (e.code == 'operation-not-allowed') {
            emit(RegisterFailed(
                errorMessage: 'Email/Password sign-in method is not enabled.'));
          } else if (e.code == 'user-disabled') {
            emit(RegisterFailed(errorMessage: 'This user has been disabled.'));
          } else if (e.code == 'network-request-failed') {
            emit(RegisterFailed(
                errorMessage:
                    'Network request failed. Please check your connection.'));
          } else if (e.code == 'too-many-requests') {
            emit(RegisterFailed(
                errorMessage: 'Too many requests. Please try again later.'));
          }
        } on Exception catch (e) {
          emit(RegisterFailed(errorMessage: 'An unknown error occurred.'));
        }
      } else if (event is ResetEvent) {
        emit(ResetLoading());
        try {
          await FirebaseAuth.instance
              .sendPasswordResetEmail(email: event.email);
          emit(ResetSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'invalid-email') {
            emit(ResetFailure(
                errorMessage: 'The email address is badly formatted.'));
          }
        } on Exception catch (e) {
          emit(ResetFailure(errorMessage: 'there was an error'));
        }
      }
    });
  }
}
