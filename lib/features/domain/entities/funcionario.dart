import 'package:equatable/equatable.dart';

class Funcionario extends Equatable {
  final int? id;
  final int? idEquipe;
  final String? nome;
  final DateTime? dataAdmissao;
  final String? email;
  final String? senha;
  final int? saldoFerias;
  final String? modalidade;
  final String? cidade;
  final String? uf;
  final bool? enabled;
  final String? username;
  final bool? rh;

  const Funcionario({
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
    this.enabled,
    this.username,
    this.rh,
  });

  @override
  List<Object?> get props => [
        id,
        idEquipe,
        nome,
        dataAdmissao,
        email,
        senha,
        saldoFerias,
        modalidade,
        cidade,
        uf,
        enabled,
        username,
        rh,
      ];
}
