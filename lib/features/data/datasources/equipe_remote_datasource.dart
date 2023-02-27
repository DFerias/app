import 'dart:convert';

import 'package:app/core/client/client.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/entities/equipe.dart';
import 'package:app/index.dart';
import 'package:dio/dio.dart';

abstract class EquipeRemoteDatasource {
  Future<Equipe> cadastrarEquipe(Equipe equipe);
  Future<List<Equipe>> getEquipes();
}

class EquipeRemoteDataSourceImpl implements EquipeRemoteDatasource {
  final Client _client;

  EquipeRemoteDataSourceImpl(
    this._client,
  );

  @override
  Future<Equipe> cadastrarEquipe(Equipe equipe) async {
    Map<String, dynamic> params = {
      "nome": equipe.nome,
      "cor": equipe.cor,
    };

    if (equipe.idLider != null) {
      params.addAll({'id_lider': equipe.idLider});
    }

    try {
      final response = await _client.dio.post(
        '$urlApi/api/equipe',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': '${App().token}',
          },
        ),
        data: json.encode(params),
      );

      if (response.statusCode == 201) {
        return EquipeModel.fromJson(response.data);
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
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw HttpError(e.message);
      } else {
        throw HttpError(e.message);
      }
    } on Failure catch (e) {
      throw HttpError(_client.getMessage(e.toString()));
    }
  }

  @override
  Future<List<Equipe>> getEquipes() async {
    try {
      final response = await _client.dio.get(
        '$urlApi/api/equipe',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': '${App().token}',
          },
        ),
      );

      if (response.statusCode == 200) {
        return List<Equipe>.from(response.data.map((i) => EquipeModel.fromJson(i['equipe'])));
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
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw HttpError(e.message);
      } else {
        throw HttpError(e.message);
      }
    } on Failure catch (e) {
      throw HttpError(_client.getMessage(e.toString()));
    }
  }
}
