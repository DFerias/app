import 'dart:convert';
import 'dart:io';

import 'package:app/index.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio/dio.dart';

const urlApi = 'http://dferias.ddns.net:54742';

class Client {
  final msgErroSessao = 'Sua sessão expirou ou foi revogada. Por favor, faça login novamente.';
  final msgErroConexao = 'Por favor, verifique a sua conexão com a Internet e tente novamente.';
  final msgErroRequest = 'Houve um erro ao processar a requisição. Por favor, tente novamente.';

  static Dio? _dio;
  static DioCacheManager? _dioCacheManager;

  Dio get dio => _dio!;

  Client() {
    final config = CacheConfig(
      defaultMaxAge: Duration.zero,
      defaultMaxStale: const Duration(days: 7),
    );

    _dio = Dio();
    _dioCacheManager = DioCacheManager(config);
    _dio!.interceptors.add(_dioCacheManager!.interceptor);
  }

  Options cacheOptions() {
    return buildCacheOptions(
      Duration.zero,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${AuthService.instance.token}',
        },
      ),
    );
  }

  String getMessage(dynamic e) {
    try {
      if (e is SocketException /* || !Get.find<Network>().hasConnection */) {
        return msgErroConexao;
      }

      try {
        var erro = json.decode(e is String ? e : e.message);
        return erro['msg'] ?? erro['message'] ?? erro['descricao'] ?? erro['erro'] ?? erro;
      } catch (_) {
        return e.message;
      }
    } catch (_) {
      return e.toString();
    }
  }
}
