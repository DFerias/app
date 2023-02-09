import 'package:app/core/errors/failure.dart';
import 'package:app/index.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

abstract class ListarModalidadesRemoteDatasource {
  Future<List<ModalidadeModel>?> listarModalidade();
}

class ListarModalidadesRemoteDatasourceImpl implements ListarModalidadesRemoteDatasource {
  static late DioCacheManager dioCacheManager;

  ListarModalidadesRemoteDatasourceImpl() {
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
