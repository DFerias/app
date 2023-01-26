import 'dart:convert';

class SolicitacaoFeriasModel {
  int? id;
  int? idFuncionario;
  int? idRh;
  int? idLider;
  DateTime? inicio;
  DateTime? fim;
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

  factory SolicitacaoFeriasModel.fromJson(String str) => SolicitacaoFeriasModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
}
