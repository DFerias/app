import 'package:equatable/equatable.dart';

class Modalidade extends Equatable {
  final int? id;
  final String? name;
  final String? authority;

  const Modalidade({
    this.id,
    this.name,
    this.authority,
  });

  @override
  List<Object?> get props => [id, name, authority];
}
