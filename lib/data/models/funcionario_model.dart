import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:app/index.dart';

class FuncionarioModel {
  GlobalKey<FormState>? formKey;
  int? id;
  int? idEquipe;
  String? nome;
  DateTime? dataAdmissao;
  String? email;
  String? senha;
  int? saldoFerias;
  String? modalidade;
  String? cidade;
  String? uf;
  List<Authority>? perfis;
  bool? enabled;
  List<Authority>? authorities;
  String? username;

  FuncionarioModel({
    this.formKey,
    this.id,
    this.idEquipe,
    this.nome,
    this.dataAdmissao,
    this.email,
    this.senha,
    this.saldoFerias,
    this.modalidade,
    this.cidade,
    this.uf,
    this.perfis,
    this.enabled,
    this.authorities,
    this.username,
  });

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
        perfis: json["perfis"] == null ? [] : List<Authority>.from(json["perfis"]!.map((x) => Authority.fromMap(x))),
        enabled: json["enabled"],
        authorities: json["authorities"] == null ? [] : List<Authority>.from(json["authorities"]!.map((x) => Authority.fromMap(x))),
        username: json["username"],
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
        "perfis": perfis == null ? [] : List<dynamic>.from(perfis!.map((x) => x.toMap())),
        "enabled": enabled,
        "authorities": authorities == null ? [] : List<dynamic>.from(authorities!.map((x) => x.toMap())),
        "username": username,
      };

  factory FuncionarioModel.fromJson(str) => FuncionarioModel.fromMap(json.decode(str));

  factory FuncionarioModel.fromCache() {
    return FuncionarioModel.fromJson(json.decode(App.cache!.getString('usuario')!));
  }

  String toJson() => json.encode(toMap());
}

class Authority {
  int? id;
  String? name;
  String? authority;

  Authority({
    this.id,
    this.name,
    this.authority,
  });

  factory Authority.fromMap(Map<String, dynamic> json) => Authority(
        id: json["id"],
        name: json["name"],
        authority: json["authority"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "authority": authority,
      };

  factory Authority.fromJson(str) => Authority.fromMap(str);

  String toJson() => json.encode(toMap());
}
