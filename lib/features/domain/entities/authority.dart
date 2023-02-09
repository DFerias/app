import 'package:equatable/equatable.dart';

class Authority extends Equatable {
  final int? id;
  final String? name;
  final String? authority;

  const Authority({
    this.id,
    this.name,
    this.authority,
  });

  @override
  List<Object?> get props => [id, name, authority];
}
