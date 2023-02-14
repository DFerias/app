import 'dart:convert';

import 'package:app/features/domain/entities/auth.dart';
import 'package:app/index.dart';

class AuthDto extends Auth {
  const AuthDto({
    String? token,
    FuncionarioModel? funcionarioM,
  }) : super(
          token: token,
          funcionario: funcionarioM,
        );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'token': token});
    result.addAll({'funcionario': funcionario});

    return result;
  }

  factory AuthDto.fromMap(Map<String, dynamic> map) {
    return AuthDto(
      token: map['token'] ?? '',
      funcionarioM: FuncionarioModel.fromMap(map['funcionario']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthDto.fromJson(String source) => AuthDto.fromMap(json.decode(source));
}
