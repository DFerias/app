import 'dart:convert';
import 'package:app/core/errors/failure.dart';
import 'package:app/index.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDatasource {
  Future<FuncionarioModel?> login(String email, String password);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client client;

  AuthRemoteDatasourceImpl({required this.client});

  @override
  Future<FuncionarioModel?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$urlApi/api/auth'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'user': email,
          'pass': password,
        }),
      );

      if (response.statusCode == 200) {
        return FuncionarioModel.fromJson(response.body);
      } else {
        if (response.statusCode == 400) {
          throw const Failure(erroRequisicao);
        }
        if (response.statusCode == 403) {
          throw const Failure(erroAutorizacao);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }
}
