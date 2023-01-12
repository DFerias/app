part of 'login_bloc.dart';

abstract class AuthState {
  AuthState();
}

class AuthInitial extends AuthState {
  AuthInitial() : super();
}

class AuthLoading extends AuthState {
  AuthLoading() : super();
}

class AuthSucess extends AuthState {
  final AuthModel authModel;

  AuthSucess(this.authModel);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
