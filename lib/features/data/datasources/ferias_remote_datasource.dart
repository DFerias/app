// ignore_for_file: depend_on_referenced_packages

import 'package:app/core/client/client.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/data/dto/solicitacao_ferias_dto.dart';
import 'package:app/features/data/models/ferias_model.dart';
import 'package:app/features/domain/entities/ferias.dart';
import 'package:app/index.dart';
import 'package:dio/dio.dart';

abstract class FeriasRemoteDatasource {
  Future<List<SolicitacaoFeriasDto>?> listarFeriasGeral();
  Future<List<Ferias>> listarHistoricoFerias(int id);
  Future<String> changeStatusFerias(int idSolicitacao, String status);
  Future<List<SolicitacaoFeriasDto>> listarFeriasEquipe();
  Future<List<SolicitacaoFeriasDto>> listarFeriasValidadas();
  Future<String> cadastrarFerias(Ferias ferias);
}

class FeriasRemoteDatasourceImpl implements FeriasRemoteDatasource {
  final Client _client;

  FeriasRemoteDatasourceImpl(this._client);

  get token => App.authService.token!;

  @override
  Future<List<SolicitacaoFeriasDto>?> listarFeriasGeral() async {
    try {
      final response = await _client.dio.get(
        '$urlApi/api/ferias',
        options: _client.cacheOptions(),
      );

      if (response.statusCode == 200) {
        return List<SolicitacaoFeriasDto>.from(response.data.map((i) => SolicitacaoFeriasDto.fromJson(i))).toList();
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
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw const HttpError(erroRequisicao);
      }
    } catch (e) {
      throw HttpError(e.toString());
    }
    return null;
  }

  @override
  Future<List<Ferias>> listarHistoricoFerias(int id) async {
    try {
      final response = await _client.dio.get(
        '$urlApi/api/ferias/funcionario/$id',
        options: _client.cacheOptions(),
      );

      if (response.statusCode == 200) {
        return List<FeriasModel>.from(response.data.map((i) => FeriasModel.fromJson(i))).toList();
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
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw HttpError(e.message);
      } else {
        throw HttpError(e.message);
      }
    } catch (e) {
      throw HttpError(e.toString());
    }
  }

  @override
  Future<String> changeStatusFerias(int idSolicitacao, String status) async {
    try {
      final response = await _client.dio.post(
        '$urlApi/api/ferias/$idSolicitacao/$status',
        options: Options(
          headers: {
            'From': 'aplicativo',
            'Authorization': '${AuthService.instance.token}',
          },
        ),
      );

      if (response.statusCode == 200) {
        return 'Status da solicitação foi atualizado para: $status';
      } else {
        if (response.statusCode == 403) {
          throw const HttpError(erroAutorizacao);
        } else {
          throw const HttpError(erroRequisicao);
        }
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw const HttpError(erroRequisicao);
      } else {
        throw HttpError(_client.getMessage(e.response?.data));
      }
    } on Failure catch (e) {
      throw HttpError(e.message);
    }
  }

  @override
  Future<List<SolicitacaoFeriasDto>> listarFeriasEquipe() async {
    try {
      final response = await _client.dio.get(
        '$urlApi/api/ferias/lider/',
        options: _client.cacheOptions(),
      );

      if (response.statusCode == 200) {
        return List<SolicitacaoFeriasDto>.from(response.data.map((i) => SolicitacaoFeriasDto.fromJson(i))).toList();
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
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw HttpError(e.message);
      } else {
        throw HttpError(e.message);
      }
    } on Failure catch (e) {
      throw HttpError(e.message);
    }
  }

  @override
  Future<String> cadastrarFerias(Ferias ferias) async {
    try {
      final response = await _client.dio.post(
        '$urlApi/api/ferias',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': '${AuthService.instance.token}',
          },
        ),
        data: {
          'idFuncionario': App.authService.usuario?.id,
          'inicio': ferias.inicio!.split(' ').first,
          'fim': ferias.fim!.split(' ').first,
        },
      );

      if (response.statusCode == 201) {
        return 'Ferias cadastradas com Sucesso!';
      } else {
        if (response.statusCode == 403) {
          throw const HttpError(erroAutorizacao);
        } else {
          throw const HttpError(erroRequisicao);
        }
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw const HttpError(erroRequisicao);
      } else {
        throw HttpError(_client.getMessage(e.response?.data));
      }
    } on Failure catch (e) {
      throw HttpError(e.message);
    }
  }

  /* @override
  Future<String> cadastrarFerias(Ferias ferias) async {
    try {
      final response = await http.post(
        Uri.parse('$urlApi/api/ferias'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${AuthService.instance.token}',
        },
        body: json.encode({
          'idFuncionario': App.authService.usuario?.id,
          'inicio': ferias.inicio!.split(' ').first,
          'fim': ferias.fim!.split(' ').first,
        }),
      );

      if (response.statusCode == 201) {
        return 'Ferias cadastradas com Sucesso!';
      } else {
        if (response.statusCode == 403) {
          throw const HttpError(erroAutorizacao);
        } else {
          throw const HttpError(erroRequisicao);
        }
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw const HttpError(erroRequisicao);
      } else {
        throw HttpError(_client.getMessage(e.response?.data));
      }
    } on Failure catch (e) {
      throw HttpError(e.message);
    }
  } */

  @override
  Future<List<SolicitacaoFeriasDto>> listarFeriasValidadas() async {
    try {
      final response = await _client.dio.get(
        '$urlApi/api/ferias/validada',
        options: _client.cacheOptions(),
      );

      if (response.statusCode == 200) {
        return List<SolicitacaoFeriasDto>.from(response.data.map((i) => SolicitacaoFeriasDto.fromJson(i))).toList();
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
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw HttpError(e.message);
      } else {
        throw HttpError(e.message);
      }
    } on Failure catch (e) {
      throw HttpError(e.message);
    }
  }
}
