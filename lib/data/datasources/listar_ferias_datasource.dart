import 'dart:convert';
import 'dart:io';
import 'package:app/index.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class ListarFeriasDatasource {
  static final ListarFeriasDatasource instance = ListarFeriasDatasource();
  static late Dio _dio;
  static late DioCacheManager dioCacheManager;

  ListarFeriasDatasource() {
    final config = CacheConfig(
      defaultMaxAge: Duration.zero,
      defaultMaxStale: const Duration(days: 7),
    );

    _dio = Dio();
    dioCacheManager = DioCacheManager(config);
    _dio.interceptors.add(dioCacheManager.interceptor);
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

  get token => 'Bearer ${App.authService.token!}';

  Future listarFeriasGeral() async {
    try {
      final response = await _dio.get(
        'http://10.0.2.2:8000/api/ferias',
        options: cacheOptions(),
      );

      if (response.statusCode != 200) {
        if (response.statusCode == 204) {
          return [];
        }
      }

      return {'statusCode': response.statusCode, 'data': response.data};
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        return {'statusCode': e.response?.statusCode, 'erro': getMessage(e.error)};
      }
    } catch (e) {
      return {'statusCode': 500, 'erro': getMessage(e)};
    }
  }
}
