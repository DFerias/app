import 'package:equatable/equatable.dart';

import 'package:app/features/domain/entities/funcionario.dart';

class Auth extends Equatable {
  final String? token;
  final Funcionario? funcionario;

  const Auth({
    this.token,
    this.funcionario,
  });

  @override
  List<Object?> get props => [token, funcionario];
}
