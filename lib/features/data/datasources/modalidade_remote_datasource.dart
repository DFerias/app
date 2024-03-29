import 'package:app/core/client/client.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/index.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

abstract class ModalidadeRemoteDatasource {
  Future<List<ModalidadeModel>?> listarModalidade();
}

class ModalidadeRemoteDatasourceImpl implements ModalidadeRemoteDatasource {
  static late DioCacheManager dioCacheManager;

  ModalidadeRemoteDatasourceImpl() {
    App().dioConfig();
  }

  get token => 'Bearer ${App.authService.token!}';

  @override
  Future<List<ModalidadeModel>?> listarModalidade() async {
    try {
      final response = await App.dio.get(
        '$urlApi/api/perfil',
        options: App().cacheOptions(),
      );

      if (response.statusCode == 200) {
        return List<ModalidadeModel>.from(response.data.map((i) => ModalidadeModel.fromJson(i))).toList();
      } else {
        if (response.statusCode == 204) {
          throw const HttpError('Desculpe não há conteúdo a ser exibido');
        }
        if (response.statusCode == 403) {
          throw const HttpError(erroAutorizacao);
        } else {
          throw const HttpError(erroRequisicao);
        }
      }
    } catch (e) {
      throw HttpError(e.toString());
    }
  }
}
