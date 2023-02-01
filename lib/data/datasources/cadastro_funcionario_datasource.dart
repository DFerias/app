import 'dart:convert';
import 'package:app/index.dart';
import 'package:http/http.dart' as http;

class CadastroFuncionarioDatasource {
  static final CadastroFuncionarioDatasource instance = CadastroFuncionarioDatasource();

  Future cadastrarFuncionario(FuncionarioModel funcionario) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/user/new'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${App().token}',
        },
        body: funcionario.toJson(),
      );

      if (response.statusCode != 200) {
        return {'statusCode': response.statusCode, 'erro': json.decode(response.body)};
      }

      return {'statusCode': response.statusCode, 'data': response.body};
    } catch (e) {
      return {'statusCode': 500, 'erro': App().getMessage(e)};
    }
  }
}
