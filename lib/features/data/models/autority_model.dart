import 'dart:convert';

import 'package:app/features/domain/entities/authority.dart';

class AuthorityModel extends Authority {
  const AuthorityModel({
    final int? id,
    final String? name,
    final String? authority,
  }) : super(
          id: id,
          name: name,
          authority: authority,
        );

  factory AuthorityModel.fromMap(Map<String, dynamic> json) => AuthorityModel(
        id: json["id"],
        name: json["name"],
        authority: json["authority"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "authority": authority,
      };

  factory AuthorityModel.fromJson(str) => AuthorityModel.fromMap(str);

  String toJson() => json.encode(toMap());
}
