import 'dart:convert';

import 'package:app/features/data/models/authority_model.dart';
import 'package:app/features/domain/entities/auth.dart';
import 'package:app/index.dart';

class AuthDto extends Auth {
  const AuthDto({
    String? token,
    FuncionarioModel? funcionarioM,
    List<AuthorityModel>? authorityM,
  }) : super(
          token: token,
          funcionario: funcionarioM,
          authority: authorityM,
        );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'token': token});
    result.addAll({'funcionario': funcionario});
    result.addAll({'authority': authority});

    return result;
  }

  factory AuthDto.fromMap(Map<String, dynamic> map) {
    return AuthDto(
      token: map['token'] ?? '',
      funcionarioM: FuncionarioModel.fromMap(map['funcionario']),
      authorityM: List<AuthorityModel>.from(map['funcionario']['authorities'].map((i) => AuthorityModel.fromMap(i))).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthDto.fromJson(source) => AuthDto.fromMap(source);
}
