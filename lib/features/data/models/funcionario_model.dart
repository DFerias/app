import 'dart:convert';

import 'package:app/index.dart';

class FuncionarioModel extends Funcionario {
  const FuncionarioModel({
    int? id,
    int? idEquipe,
    String? nome,
    DateTime? dataAdmissao,
    String? email,
    String? senha,
    int? saldoFerias,
    String? modalidade,
    String? cidade,
    String? uf,
    bool? enabled,
    String? username,
    bool? rh,
    // bool? lider,
  }) : super(
          id: id,
          idEquipe: idEquipe,
          nome: nome,
          dataAdmissao: dataAdmissao,
          email: email,
          senha: senha,
          saldoFerias: saldoFerias,
          modalidade: modalidade,
          cidade: cidade,
          uf: uf,
          enabled: enabled,
          username: username,
          rh: rh,
        );

  factory FuncionarioModel.fromMap(Map<String, dynamic> json) => FuncionarioModel(
        id: json["id"],
        idEquipe: json["idEquipe"],
        nome: json["nome"],
        dataAdmissao: json["dataAdmissao"] == null ? null : DateTime.parse(json["dataAdmissao"]),
        email: json["email"],
        senha: json["pass"],
        saldoFerias: json["saldoFerias"],
        modalidade: json["modalidade"],
        cidade: json["cidade"],
        uf: json["uf"],
        enabled: json["enabled"],
        username: json["username"],
        rh: (json['perfis']).toString().contains('RH') ? true : false,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "idEquipe": idEquipe,
        "nome": nome,
        "dataAdmissao": "${dataAdmissao!.year.toString().padLeft(4, '0')}-${dataAdmissao!.month.toString().padLeft(2, '0')}-${dataAdmissao!.day.toString().padLeft(2, '0')}",
        "email": email,
        "pass": senha,
        "saldoFerias": saldoFerias,
        "modalidade": modalidade,
        "cidade": cidade,
        "uf": uf,
        "enabled": enabled,
        "username": username,
      };

  factory FuncionarioModel.fromJson(str) => FuncionarioModel.fromMap(json.decode(str));

  factory FuncionarioModel.fromCache() {
    return FuncionarioModel.fromJson(json.decode(App.cache!.getString('usuario')!));
  }

  String toJson() => json.encode(toMap());
}
