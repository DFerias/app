import 'package:app/services/app.dart';

class ListarModalidadesDatasource {
  static final ListarModalidadesDatasource instance = ListarModalidadesDatasource();

  Future listarModalidade() async {
    try {
      final response = await App.dio.get(
        'http://10.0.2.2:8000/api/perfil',
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
