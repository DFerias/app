import 'dart:convert';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/data/dto/auth_dto.dart';
import 'package:app/index.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDatasource {
  Future<AuthDto> login(String email, String password);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client client;

  AuthRemoteDatasourceImpl({required this.client});

  @override
  Future<AuthDto> login(String email, String password) async {
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
        return AuthDto.fromJson(response.body);
      } else {
        if (response.statusCode == 400) {
          throw const HttpError(erroRequisicao);
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
