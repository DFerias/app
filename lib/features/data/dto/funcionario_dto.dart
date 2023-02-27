import 'dart:convert';

import 'package:app/features/data/models/authority_model.dart';
import 'package:app/index.dart';

class FuncionarioDto {
  FuncionarioModel funcionario;
  AuthorityModel authority;

  FuncionarioDto({
    required this.funcionario,
    required this.authority,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'funcionario': funcionario.toMap()});
    result.addAll({'authority': authority.toMap()});

    return result;
  }

  factory FuncionarioDto.fromMap(Map<String, dynamic> map) {
    return FuncionarioDto(
      funcionario: FuncionarioModel.fromMap(map['funcionario']),
      authority: AuthorityModel.fromMap(map['authority']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FuncionarioDto.fromJson(String source) => FuncionarioDto.fromMap(json.decode(source));
}
