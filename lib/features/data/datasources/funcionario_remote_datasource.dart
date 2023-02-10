import 'package:app/core/errors/failure.dart';
import 'package:app/index.dart';
import 'package:http/http.dart' as http;

abstract class FuncionarioRemoteDatasource {
  Future<FuncionarioModel?> cadastrarFuncionario(FuncionarioModel? funcionario);
}

class FuncionarioRemoteDatasourceImpl implements FuncionarioRemoteDatasource {
  final http.Client client;

  FuncionarioRemoteDatasourceImpl({required this.client});

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
        return FuncionarioModel.fromJson(response.body);
      } else {
        if (response.statusCode == 403) {
          throw const HttpError(erroAutorizacao);
        } else {
          throw const HttpError(erroRequisicao);
        }
      }
    } catch (e) {
      throw HttpError('$e');
    }
  }
}
