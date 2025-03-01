part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}

final class RegisterCubitInitial extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterSuccessfully extends AuthState {}

final class RegisterFailed extends AuthState {
  final String errorMessage;

  RegisterFailed({required this.errorMessage});
}

class ResetInitial extends AuthState {}

class ResetLoading extends AuthState {}

class ResetFailure extends AuthState {
  final String errorMessage;

  ResetFailure({required this.errorMessage});
}

class ResetSuccess extends AuthState {}
