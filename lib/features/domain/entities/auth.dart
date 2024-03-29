import 'package:equatable/equatable.dart';

import 'package:app/features/domain/entities/authority.dart';
import 'package:app/features/domain/entities/funcionario.dart';

class Auth extends Equatable {
  final String? token;
  final Funcionario? funcionario;
  final List<Authority>? authority;
  final bool? isLider;

  const Auth({
    this.token,
    this.funcionario,
    this.authority,
    this.isLider,
  });

  @override
  List<Object?> get props => [token, funcionario, authority, isLider];
}
