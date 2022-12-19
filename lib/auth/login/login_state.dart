part of 'login_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final String? email;
  final String? password;

  AuthLoaded({
    this.email,
    this.password,
  });

  AuthLoaded copyWith({
    String? email,
    String? password,
  }) {
    return AuthLoaded(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class AuthError extends AuthState {}
