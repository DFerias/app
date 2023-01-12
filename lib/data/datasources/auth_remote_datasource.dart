import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  static final AuthRemoteDatasource instance = AuthRemoteDatasource();

  Future<dynamic> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/auth'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'user': email,
          'pass': password,
        }),
      );

      if (response.statusCode != 200) {
        if (response.statusCode == 400) {
          inspect(response.body);
        }
        if (response.statusCode == 403) {
          inspect(response.body);
        }
      }

      return {'statusCode': response.statusCode, 'data': response.body};
    } catch (e) {
      throw Exception(e);
    }
  }
}
