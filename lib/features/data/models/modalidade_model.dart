import 'dart:convert';

import 'package:app/features/domain/entities/modalidade.dart';

class ModalidadeModel extends Modalidade {
  const ModalidadeModel({
    int? id,
    String? name,
    String? authority,
  }) : super(
          id: id,
          name: name,
          authority: authority,
        );

  factory ModalidadeModel.fromMap(Map<String, dynamic> json) => ModalidadeModel(
        id: json["id"],
        name: json["name"],
        authority: json["authority"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "authority": authority,
      };

  factory ModalidadeModel.fromJson(value) => ModalidadeModel.fromMap(value);

  String toJson() => json.encode(toMap());
}
