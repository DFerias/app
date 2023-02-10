import 'dart:convert';

import 'package:app/index.dart';

class AuthDto {
  String token;
  FuncionarioModel funcionarioModel;

  AuthDto({
    required this.token,
    required this.funcionarioModel,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'token': token});
    result.addAll({'funcionarioModel': funcionarioModel.toMap()});

    return result;
  }

  factory AuthDto.fromMap(Map<String, dynamic> map) {
    return AuthDto(
      token: map['token'] ?? '',
      funcionarioModel: FuncionarioModel.fromMap(map['funcionarioModel']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthDto.fromJson(String source) => AuthDto.fromMap(json.decode(source));
}
