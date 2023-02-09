import 'package:app/core/errors/failure.dart';
import 'package:app/index.dart';
import 'package:http/http.dart' as http;

abstract class CadastroFuncionarioRemoteDatasource {
  Future<FuncionarioModel?> cadastrarFuncionario(FuncionarioModel? funcionario);
}

class CadastroFuncionarioDatasourceImpl implements CadastroFuncionarioRemoteDatasource {
  final http.Client client;

  CadastroFuncionarioDatasourceImpl({required this.client});

  @override
  Future<FuncionarioModel?> cadastrarFuncionario(FuncionarioModel? funcionario) async {
    try {
      final response = await client.post(
        Uri.parse('$urlApi/api/user/new'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${App().token}',
        },
        body: funcionario?.toJson(),
      );

      if (response.statusCode == 200) {
      } else {
        if (response.statusCode == 403) {
          throw const HttpError(erroAutorizacao);
        }
        if (response.statusCode == 400) {
          throw const HttpError(erroRequisicao);
        } else {
          throw const HttpError(erroRequisicao);
        }
      }

      return FuncionarioModel.fromJson(response.body);
    } catch (e) {
      throw HttpError('$e');
    }
  }
}
