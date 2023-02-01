// ignore_for_file: file_names
import 'dart:convert';
import 'package:app/index.dart';

class AuthModel {
  String? token;
  FuncionarioModel? funcionario;

  AuthModel({
    this.token,
    this.funcionario,
  });

  factory AuthModel.fromMap(Map<String, dynamic> json) => AuthModel(
        token: json["token"],
        funcionario: json["funcionario"] == null ? null : FuncionarioModel.fromMap(json["funcionario"]),
      );

  Map<String, dynamic> toMap() => {
        "token": token,
        "funcionario": funcionario?.toMap(),
      };

  factory AuthModel.fromJson(String str) => AuthModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
}
