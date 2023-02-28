import 'dart:convert';

import 'package:app/core/client/client.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/index.dart';
import 'package:dio/dio.dart';

abstract class FuncionarioRemoteDatasource {
  Future<String> cadastrarFuncionario(Funcionario? funcionario);
  Future<List<Funcionario>> getFuncionarios();
}

class FuncionarioRemoteDatasourceImpl implements FuncionarioRemoteDatasource {
  final Client client;

  FuncionarioRemoteDatasourceImpl({required this.client});

  @override
  Future<String> cadastrarFuncionario(Funcionario? funcionario) async {
    try {
      final response = await client.dio.post(
        '$urlApi/api/user/new',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': '${App().token}',
          },
        ),
        data: json.encode({
          "nome": funcionario?.nome,
          "email": funcionario?.email,
          "pass": funcionario?.senha,
          "cidade": funcionario?.cidade,
          "idEquipe": funcionario?.idEquipe,
          "uf": funcionario?.uf,
          "modalidade": funcionario?.modalidade,
          "dataAdmissao": "${funcionario?.dataAdmissao!.year.toString().padLeft(4, '0')}-${funcionario?.dataAdmissao!.month.toString().padLeft(2, '0')}-${funcionario?.dataAdmissao!.day.toString().padLeft(2, '0')}",
        }),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        if (response.statusCode == 403) {
          throw const HttpError(erroAutorizacao);
        } else {
          throw const HttpError(erroRequisicao);
        }
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw HttpError(e.message);
      } else {
        throw HttpError(client.getMessage(e));
      }
    } on Failure catch (e) {
      throw HttpError(e.message);
    }
  }

  @override
  Future<List<Funcionario>> getFuncionarios() async {
    try {
      final response = await client.dio.get(
        '$urlApi/api/users',
        options: client.cacheOptions()
          ..headers?.addAll({
            'Authorization': '${App().token}',
          }),
      );

      if (response.statusCode == 200) {
        return List<FuncionarioModel>.from(response.data.map((i) => FuncionarioModel.fromMap(i)));
      } else {
        if (response.statusCode == 403) {
          throw const HttpError(erroAutorizacao);
        } else {
          throw const HttpError(erroRequisicao);
        }
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw HttpError(e.message);
      } else {
        throw HttpError(client.getMessage(e));
      }
    } on Failure catch (e) {
      throw HttpError(e.message);
    }
  }
}
