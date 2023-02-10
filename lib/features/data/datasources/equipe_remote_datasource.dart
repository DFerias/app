import 'dart:convert';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/entities/equipe.dart';
import 'package:app/index.dart';
import 'package:http/http.dart' as http;

abstract class EquipeRemoteDatasource {
  Future<EquipeModel?> cadastrarEquipe(Equipe equipe);
}

class EquipeRemoteDataSourceImpl implements EquipeRemoteDatasource {
  final http.Client client;

  EquipeRemoteDataSourceImpl({required this.client});

  @override
  Future<EquipeModel?> cadastrarEquipe(Equipe equipe) async {
    Map<String, dynamic> params = {
      "nome": equipe.nome,
      "cor": equipe.cor,
    };

    if (equipe.id != null) {
      params.addAll({'id': equipe.id});
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
        if (response.statusCode == 400) {
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
