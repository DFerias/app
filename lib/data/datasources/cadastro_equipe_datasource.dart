import 'dart:convert';

import 'package:app/index.dart';
import 'package:http/http.dart' as http;

class CadastroEquipeDatasource {
  static final CadastroEquipeDatasource instance = CadastroEquipeDatasource();

  Future cadastroEquipe(int? id, String? nome, String? cor) async {
    Map<String, dynamic> params = {
      "nome": nome,
      "cor": cor,
    };

    if (id != null) {
      params.addAll({'id': id});
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/equipe'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${App().token}',
        },
        body: json.encode(params),
      );

      if (response.statusCode != 201) {
        return {'statusCode': response.statusCode, 'erro': json.decode(response.body)};
      }

      return {'statusCode': response.statusCode, 'data': json.decode(response.body)};
    } catch (e) {
      return {'statusCode': 500, 'erro': App().getMessage(e)};
    }
  }
}
