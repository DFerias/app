import 'package:app/index.dart';

class ListarModalidadesDatasource {
  static final ListarModalidadesDatasource instance = ListarModalidadesDatasource();

  Future listarModalidade() async {
    try {
      final response = await App.dio.get(
        '$urlApi/api/perfil',
        options: App().cacheOptions(),
      );

      if (response.statusCode != 200) {
        return {'statusCode': response.statusCode, 'erro': response.data};
      }

      return {'statusCode': response.statusCode, 'data': response.data};
    } catch (e) {
      return {'statusCode': 500, 'erro': App().getMessage(e)};
    }
  }
}
