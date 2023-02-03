// ignore_for_file: depend_on_referenced_packages
import 'package:app/index.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class ListarFeriasDatasource {
  static final ListarFeriasDatasource instance = ListarFeriasDatasource();
  // static late Dio _dio;
  static late DioCacheManager dioCacheManager;

  ListarFeriasDatasource() {
    App().dioConfig();
  }

  get token => 'Bearer ${App.authService.token!}';

  Future listarFeriasGeral() async {
    try {
      final response = await App.dio.get(
        '$urlApi/api/ferias',
        options: App().cacheOptions(),
      );

      if (response.statusCode != 200) {
        if (response.statusCode == 204) {
          return [];
        }
      }

      return {'statusCode': response.statusCode, 'data': response.data};
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        return {'statusCode': e.response?.statusCode, 'erro': App().getMessage(e.error)};
      }
    } catch (e) {
      return {'statusCode': 500, 'erro': App().getMessage(e)};
    }
  }
}
