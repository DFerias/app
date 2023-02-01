import 'dart:convert';
import 'package:app/data/models/funcionario_model.dart';

class SolicitacaoFeriasModel {
  SolicitacaoFeriasModel({
    this.funcionario,
    this.ferias,
  });

  FuncionarioModel? funcionario;
  Ferias? ferias;

  factory SolicitacaoFeriasModel.fromMap(Map<String, dynamic> json) => SolicitacaoFeriasModel(
        funcionario: json["funcionario"] == null ? null : FuncionarioModel.fromMap(json["funcionario"]),
        ferias: json["ferias"] == null ? null : Ferias.fromMap(json["ferias"]),
      );

  Map<String, dynamic> toMap() => {
        "funcionario": funcionario?.toMap(),
        "ferias": ferias?.toMap(),
      };

  factory SolicitacaoFeriasModel.fromJson(str) => SolicitacaoFeriasModel.fromMap(str);

  String toJson() => json.encode(toMap());
}

class Ferias {
  int? id;
  int? idFuncionario;
  int? idRh;
  int? idLider;
  DateTime? inicio;
  DateTime? fim;
  String? status;
  String? observacoesRh;
  String? observacoesLider;

  Ferias({
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

  factory Ferias.fromJson(String str) => Ferias.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ferias.fromMap(Map<String, dynamic> json) => Ferias(
        id: json["id"],
        idFuncionario: json["idFuncionario"],
        idRh: json["idRh"],
        idLider: json["idLider"],
        inicio: json["inicio"] == null ? null : DateTime.parse(json["inicio"]),
        fim: json["fim"] == null ? null : DateTime.parse(json["fim"]),
        status: json["status"],
        observacoesRh: json["observacoesRh"],
        observacoesLider: json["observacoesLider"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "idFuncionario": idFuncionario,
        "idRh": idRh,
        "idLider": idLider,
        "inicio": "${inicio!.year.toString().padLeft(4, '0')}-${inicio!.month.toString().padLeft(2, '0')}-${inicio!.day.toString().padLeft(2, '0')}",
        "fim": "${fim!.year.toString().padLeft(4, '0')}-${fim!.month.toString().padLeft(2, '0')}-${fim!.day.toString().padLeft(2, '0')}",
        "status": status,
        "observacoesRh": observacoesRh,
        "observacoesLider": observacoesLider,
      };
}
