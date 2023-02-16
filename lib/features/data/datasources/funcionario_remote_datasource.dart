import 'package:app/core/errors/failure.dart';
import 'package:app/index.dart';
import 'package:http/http.dart' as http;

abstract class FuncionarioRemoteDatasource {
  Future<String> cadastrarFuncionario(Funcionario? funcionario);
}

class FuncionarioRemoteDatasourceImpl implements FuncionarioRemoteDatasource {
  final http.Client client;

  FuncionarioRemoteDatasourceImpl({required this.client});

  @override
  Future<String> cadastrarFuncionario(Funcionario? funcionario) async {
    try {
      final response = await client.post(
        Uri.parse('$urlApi/api/user/new'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${App().token}',
        },
        body: (funcionario as FuncionarioModel).toJson(),
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        if (response.statusCode == 403) {
          throw const HttpError(erroAutorizacao);
        } else {
          throw const HttpError(erroRequisicao);
        }
      }
    } on Failure catch (e) {
      throw HttpError(e.message);
    }
  }
}
