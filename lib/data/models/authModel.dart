// ignore_for_file: file_names

import 'dart:convert';

class AuthModel {
  String? type;
  String? token;

  AuthModel({
    this.type,
    this.token,
  });

  factory AuthModel.fromMap(Map<String, dynamic> json) => AuthModel(
        type: json["type"],
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "token": token,
      };

  factory AuthModel.fromJson(String str) => AuthModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
}
