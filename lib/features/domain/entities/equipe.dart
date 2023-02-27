import 'package:equatable/equatable.dart';

class Equipe extends Equatable {
  final int? id;
  final int? idLider;
  final String? nome;
  final String? cor;

  const Equipe({
    this.id,
    this.idLider,
    this.nome,
    this.cor,
  });

  @override
  List<Object?> get props => [id, idLider, nome, cor];
}
