import 'package:equatable/equatable.dart';

class Ferias extends Equatable {
  final int? id;
  final int? idFuncionario;
  final int? idRh;
  final int? idLider;
  final String? inicio;
  final String? fim;
  final String? status;
  final String? observacoesRh;
  final String? observacoesLider;

  const Ferias({
    this.id,
    this.idFuncionario,
    this.idRh,
    this.idLider,
    this.inicio,
    this.fim,
    this.status,
    this.observacoesRh,
    this.observacoesLider,
  });

  @override
  List<Object?> get props => [
        id,
        idFuncionario,
        idRh,
        idLider,
        inicio,
        fim,
        status,
        observacoesRh,
        observacoesLider,
      ];
}
