import 'dart:convert';

import 'package:app/features/domain/entities/ferias.dart';
import 'package:intl/intl.dart';

class FeriasModel extends Ferias {
  const FeriasModel({
    int? id,
    int? idFuncionario,
    int? idRh,
    int? idLider,
    String? inicio,
    String? fim,
    String? diasAgendados,
    String? status,
    String? observacoesRh,
    String? observacoesLider,
  }) : super(
          id: id,
          idFuncionario: idFuncionario,
          idRh: idRh,
          idLider: idLider,
          inicio: inicio,
          fim: fim,
          diasAgendados: diasAgendados,
          status: status,
          observacoesRh: observacoesRh,
          observacoesLider: observacoesLider,
        );

  factory FeriasModel.fromJson(str) => FeriasModel.fromMap(str);

  String toJson() => json.encode(toMap());

  factory FeriasModel.fromMap(Map<String, dynamic> json) {
    String? calcularDiasAgendados() {
      if (json['inicio'] != null && json['fim'] != null) {
        var inicio = DateTime.parse(json['inicio']);
        var fim = DateTime.parse(json['fim']);

        return (fim.difference(inicio).inDays + 1).toString();
      } else {
        return null;
      }
    }

    return FeriasModel(
      id: json["id"],
      idFuncionario: json["idFuncionario"],
      idRh: json["idRh"],
      idLider: json["idLider"],
      inicio: json['inicio'] == null ? null : DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(json['inicio'])),
      fim: json['fim'] == null ? null : DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(json['fim'])),
      diasAgendados: calcularDiasAgendados(),
      status: json["status"],
      observacoesRh: json["observacoes_rh"],
      observacoesLider: json["observacoes_lider"],
    );
  }

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
