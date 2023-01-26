import 'dart:convert';
import 'package:app/index.dart';
import 'package:http/http.dart' as http;

class SolicitacaoFeriasDatasource {
  static final SolicitacaoFeriasDatasource instance = SolicitacaoFeriasDatasource();

  Future enviarSolicitacao(String? dataInicial, String? dataFinal) async {
    Map<String, dynamic> params = {
      'idFuncionario': App.authService.usuario?.id,
      'inicio': dataInicial,
      'fim': dataFinal,
    };

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/ferias'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${App().token}',
        },
        body: json.encode(params),
      );

      if (response.statusCode != 201) {
        return {'statusCode': response.statusCode, 'erro': json.decode(response.body)};
      }

      return {'statusCode': response.statusCode, 'data': response.body};
    } catch (e) {
      return {'statusCode': 500, 'erro': App().getMessage(e)};
    }
  }
}
