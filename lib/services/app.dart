import 'package:app/auth/login/login_bloc.dart';
import 'package:flutter/material.dart';

class App {
  static final App instance = App();
  static final navigator = GlobalKey<NavigatorState>();
  static final authBloc = AuthBloc.instance;

  static BuildContext context = navigator.currentState!.overlay!.context;
}
