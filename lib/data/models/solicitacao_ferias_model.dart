import 'dart:convert';
import 'package:app/data/models/funcionario_model.dart';
import 'package:intl/intl.dart';

class SolicitacaoFeriasModel {
  SolicitacaoFeriasModel({
    this.funcionario,
    this.ferias,
  });

  FuncionarioModel? funcionario;
  FeriasModel? ferias;

  factory SolicitacaoFeriasModel.fromMap(Map<String, dynamic> json) => SolicitacaoFeriasModel(
        funcionario: json["funcionario"] == null ? null : FuncionarioModel.fromMap(json["funcionario"]),
        ferias: json["ferias"] == null ? null : FeriasModel.fromMap(json["ferias"]),
      );

  Map<String, dynamic> toMap() => {
        "funcionario": funcionario?.toMap(),
        "ferias": ferias?.toMap(),
      };

  factory SolicitacaoFeriasModel.fromJson(str) => SolicitacaoFeriasModel.fromMap(str);

  String toJson() => json.encode(toMap());
}

class FeriasModel {
  int? id;
  int? idFuncionario;
  int? idRh;
  int? idLider;
  String? inicio;
  String? fim;
  String? status;
  String? observacoesRh;
  String? observacoesLider;

  FeriasModel({
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

  factory FeriasModel.fromJson(str) => FeriasModel.fromMap(json.decode(str));

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
