part of 'login_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  success,
  error,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final String? email;
  final String? password;
  final Auth? auth;
  final String? errorMessage;

  const AuthState(
    this.status,
    this.email,
    this.password,
    this.auth,
    this.errorMessage,
  );

  const AuthState.initial()
      : status = AuthStatus.initial,
        email = null,
        password = null,
        auth = null,
        errorMessage = null;

  @override
  List<Object?> get props => [status, email, password, auth, errorMessage];

  AuthState copyWith({
    AuthStatus? status,
    String? email,
    String? password,
    Auth? auth,
    String? errorMessage,
  }) {
    return AuthState(
      status ?? this.status,
      email ?? this.email,
      password ?? this.password,
      auth ?? this.auth,
      errorMessage ?? this.errorMessage,
    );
  }
}

/* class AuthInitial extends AuthState {
  AuthInitial() : super();
}

class AuthLoading extends AuthState {
  AuthLoading() : super();
}

class AuthSucess extends AuthState {
  final Auth auth;

  AuthSucess(this.auth);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
} */
