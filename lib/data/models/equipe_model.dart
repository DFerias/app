import 'dart:convert';

class EquipeModel {
  int? id;
  int? idLider;
  String? nome;
  String? cor;

  EquipeModel({
    this.id,
    this.idLider,
    this.nome,
    this.cor,
  });

  factory EquipeModel.fromMap(Map<String, dynamic> json) => EquipeModel(
        id: json["id"],
        nome: json["nome"],
        cor: json["cor"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
        "cor": cor,
      };

  factory EquipeModel.fromJson(str) => EquipeModel.fromMap(str);

  String toJson() => json.encode(toMap());
}
