import 'dart:convert';

import 'package:app/features/domain/entities/ferias.dart';
import 'package:intl/intl.dart';

class FeriasModel extends Ferias {
  const FeriasModel({
    int? id,
    int? idFuncionario,
    int? idRh,
    int? idLider,
    String? inicio,
    String? fim,
    String? status,
    String? observacoesRh,
    String? observacoesLider,
  }) : super(
          id: id,
          idFuncionario: idFuncionario,
          idRh: idRh,
          idLider: idLider,
          inicio: inicio,
          fim: fim,
          status: status,
          observacoesRh: observacoesRh,
          observacoesLider: observacoesLider,
        );

  factory FeriasModel.fromJson(str) => FeriasModel.fromMap(str);

  String toJson() => json.encode(toMap());

  factory FeriasModel.fromMap(Map<String, dynamic> json) => FeriasModel(
        id: json["id"],
        idFuncionario: json["idFuncionario"],
        idRh: json["idRh"],
        idLider: json["idLider"],
        inicio: json['inicio'] == null ? null : DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(json['inicio'])),
        fim: json['fim'] == null ? null : DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(json['fim'])),
        status: json["status"],
        observacoesRh: json["observacoesRh"],
        observacoesLider: json["observacoesLider"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "idFuncionario": idFuncionario,
        "idRh": idRh,
        "idLider": idLider,
        "inicio": inicio,
        "fim": fim,
        "status": status,
        "observacoesRh": observacoesRh,
        "observacoesLider": observacoesLider,
      };
}
