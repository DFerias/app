import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is Login) {
        if (event.email.isEmpty || event.password.isEmpty) {
          emit(AuthError());
        } else {
          emit(AuthLoading());
          await Future.delayed(const Duration(seconds: 3), () {
            emit(AuthLoaded(email: event.email, password: event.password));
          });
        }
      }
    });
  }
}
