import 'dart:convert';
import 'package:app/core/errors/failure.dart';
import 'package:app/index.dart';
import 'package:http/http.dart' as http;

abstract class CadastroEquipeRemoteDatasource {
  Future<EquipeModel?> cadastrarEquipe(int? id, String? nome, String? cor);
}

class CadastroEquipeRemoteDataSourceImpl implements CadastroEquipeRemoteDatasource {
  final http.Client client;

  CadastroEquipeRemoteDataSourceImpl({required this.client});

  @override
  Future<EquipeModel?> cadastrarEquipe(int? id, String? nome, String? cor) async {
    Map<String, dynamic> params = {
      "nome": nome,
      "cor": cor,
    };

    if (id != null) {
      params.addAll({'id': id});
    }

    try {
      final response = await client.post(
        Uri.parse('$urlApi/api/equipe'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${App().token}',
        },
        body: json.encode(params),
      );

      if (response.statusCode == 201) {
        return EquipeModel.fromJson(response.body);
      } else {
        if (response.statusCode == 403) {
          throw const HttpError(erroAutorizacao);
        }
        if (response.statusCode == 403) {
          throw const HttpError(erroRequisicao);
        } else {
          throw const HttpError('Erro não catalogado');
        }
      }
    } catch (e) {
      throw const HttpError(erroRequisicao);
    }
  }
}
