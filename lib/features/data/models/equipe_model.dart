import 'dart:convert';

import 'package:app/features/domain/entities/equipe.dart';

class EquipeModel extends Equipe {
  const EquipeModel({
    int? id,
    int? idLider,
    String? nome,
    String? cor,
  }) : super(
          id: id,
          idLider: idLider,
          nome: nome,
          cor: cor,
        );

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
