// ignore_for_file: depend_on_referenced_packages
import 'package:app/core/errors/failure.dart';
import 'package:app/features/data/dto/solicitacao_ferias_dto.dart';
import 'package:app/features/data/models/ferias_model.dart';
import 'package:app/features/domain/entities/ferias.dart';
import 'package:app/index.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

abstract class FeriasRemoteDatasource {
  Future<List<SolicitacaoFeriasDto>?> listarFeriasGeral();
  Future<FeriasModel?> cadastrarFerias(Ferias ferias);
}

class FeriasRemoteDatasourceImpl implements FeriasRemoteDatasource {
  static late DioCacheManager dioCacheManager;

  FeriasRemoteDatasourceImpl() {
    App().dioConfig();
  }

  get token => 'Bearer ${App.authService.token!}';

  @override
  Future<List<SolicitacaoFeriasDto>?> listarFeriasGeral() async {
    try {
      final response = await App.dio.get(
        '$urlApi/api/ferias',
        options: App().cacheOptions(),
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
  Future<FeriasModel?> cadastrarFerias(Ferias ferias) async {
    try {
      final response = await App.dio.post(
        '$urlApi/api/ferias',
        options: App().cacheOptions(),
        queryParameters: {
          'idFuncionario': App.authService.usuario?.id,
          'inicio': ferias.inicio,
          'fim': ferias.fim,
        },
      );

      if (response.statusCode == 201) {
        return FeriasModel.fromJson(response.data);
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
      }
    } catch (e) {
      throw HttpError(e.toString());
    }
    return null;
  }
}
