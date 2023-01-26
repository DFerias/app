import 'dart:convert';
import 'package:intl/intl.dart';

class SolicitacaoFeriasModel {
  int? id;
  int? idFuncionario;
  int? idRh;
  int? idLider;
  String? inicio;
  String? fim;
  String? status;
  String? observacoesRh;
  String? observacoesLider;

  SolicitacaoFeriasModel({
    this.id,
    this.idFuncionario,
    this.idRh,
    this.idLider,
    this.inicio,
    this.fim,
    this.status,
    this.observacoesRh,
    this.observacoesLider,
  });

  factory SolicitacaoFeriasModel.fromMap(Map<String, dynamic> json) => SolicitacaoFeriasModel(
        id: json["id"],
        idFuncionario: json["idFuncionario"],
        idRh: json["idRh"],
        idLider: json["idLider"],
        inicio: json["inicio"] == null ? null : DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(json["inicio"])),
        fim: json["fim"] == null ? null : DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(json["fim"])),
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

  factory SolicitacaoFeriasModel.fromJson(String str) => SolicitacaoFeriasModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
}
