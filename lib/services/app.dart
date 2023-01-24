import 'package:app/index.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App {
  static final App instance = App();
  static final navigator = GlobalKey<NavigatorState>();
  static SharedPreferences? cache;
  static AuthService authService = AuthService.instance;
  static final authBloc = AuthBloc.instance;
  static final dataSolicitacao = DataSolicitacaoBloc.instance;

  static BuildContext context = navigator.currentState!.overlay!.context;

  Future<void> inicializar() async {
    cache = await SharedPreferences.getInstance();
  }
}
