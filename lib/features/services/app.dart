// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';
import 'package:app/index.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class App {
  static final App instance = App();
  static final navigator = GlobalKey<NavigatorState>();
  static SharedPreferences? cache;
  static AuthService authService = AuthService.instance;
  static final authBloc = AuthBloc.instance;
  static final listaFeriasGeral = ListarFeriasBloc.instance;

  static BuildContext context = navigator.currentState!.overlay!.context;
  static late Dio dio;
  static late DioCacheManager dioCacheManager;

  get token => App.authService.token!;

  Future<void> inicializar() async {
    cache = await SharedPreferences.getInstance();
  }

  void dioConfig() {
    final config = CacheConfig(
      defaultMaxAge: Duration.zero,
      defaultMaxStale: const Duration(days: 7),
    );

    dio = Dio();
    dioCacheManager = DioCacheManager(config);
    dio.interceptors.add(dioCacheManager.interceptor);
  }

  Options cacheOptions() {
    return buildCacheOptions(
      Duration.zero,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      ),
    );
  }

  String? getMessage(dynamic e) {
    try {
      if (e is SocketException && (e.osError!.errorCode == 7 || e.osError!.errorCode == 101)) {
        return 'Falha na comunicação, verifique e tente novamente.';
      }

      try {
        var erro = json.decode(e.message);
        var retorno = erro['errors'] != null ? erro['errors'].values.toList()[0] : erro.values.toList()[0];
        return retorno is List ? retorno[0] : retorno ?? erro;
      } catch (_) {
        return e.message;
      }
    } catch (_) {
      return e.toString();
    }
  }
}
