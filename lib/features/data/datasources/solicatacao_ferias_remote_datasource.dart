import 'dart:convert';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/data/models/ferias_model.dart';
import 'package:app/index.dart';
import 'package:http/http.dart' as http;

abstract class SolicitacaoFeriasRemoteDatasource {
  Future<FeriasModel?> enviarSolicitacaoFerias(String? dataInicial, String dataFinal);
}

class SolicatacaoFeriasRemoteDatasourceImpl implements SolicitacaoFeriasRemoteDatasource {
  final http.Client cliente;

  SolicatacaoFeriasRemoteDatasourceImpl({required this.cliente});

  @override
  Future<FeriasModel?> enviarSolicitacaoFerias(String? dataInicial, String dataFinal) async {
    Map<String, dynamic> params = {
      'idFuncionario': App.authService.usuario?.id,
      'inicio': dataInicial,
      'fim': dataFinal,
    };

    try {
      final response = await http.post(
        Uri.parse('$urlApi/api/ferias'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${App().token}',
        },
        body: json.encode(params),
      );

      if (response.statusCode == 201) {
        return FeriasModel.fromJson(response.body);
      } else {
        if (response.statusCode == 204) {
          throw HttpError(response.body);
        }
        if (response.statusCode == 403) {
          throw const HttpError(erroAutorizacao);
        } else {
          throw const HttpError(erroRequisicao);
        }
      }
    } catch (e) {
      throw HttpError(e.toString());
    }
  }
}

Future enviarSolicitacao(String? dataInicial, String? dataFinal) async {}
