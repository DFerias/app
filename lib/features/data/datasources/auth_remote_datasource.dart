import 'dart:convert';
import 'package:app/core/client/client.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/data/dto/auth_dto.dart';
import 'package:app/index.dart';

abstract class AuthRemoteDatasource {
  Future<AuthDto> login(String email, String password);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Client _client;

  AuthRemoteDatasourceImpl(this._client);

  @override
  Future<AuthDto> login(String email, String password) async {
    try {
      final response = await _client.dio.post(
        '$urlApi/api/auth',
        options: _client.cacheOptions(),
        data: json.encode({
          'user': email,
          'pass': password,
        }),
      );

      if (response.statusCode == 200) {
        return AuthDto.fromJson(response.data);
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
    } on Failure catch (e) {
      throw HttpError(e.message);
    }
  }
}
