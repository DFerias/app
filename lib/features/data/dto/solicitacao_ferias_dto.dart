import 'dart:convert';

import 'package:app/features/data/models/ferias_model.dart';
import 'package:app/index.dart';

class SolicitacaoFeriasDto {
  FuncionarioModel? funcionario;
  FeriasModel? ferias;

  SolicitacaoFeriasDto({required this.funcionario, required this.ferias});

  SolicitacaoFeriasDto.fromMap(Map<String, dynamic> json) {
    funcionario = json['funcionario'] != null ? FuncionarioModel.fromJson(json['funcionario']) : null;
    ferias = json['ferias'] != null ? FeriasModel.fromJson(json['ferias']) : null;
  }

  Map<String, dynamic> toMap() => {
        "funcionario": funcionario?.toMap(),
        "ferias": ferias?.toMap(),
      };

  factory SolicitacaoFeriasDto.fromJson(str) => SolicitacaoFeriasDto.fromMap(str);

  String toJson() => json.encode(toMap());
}
