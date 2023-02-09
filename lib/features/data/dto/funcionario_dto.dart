import 'package:app/features/domain/entities/authority.dart';
import 'package:app/index.dart';

class FuncionarioDto {
  FuncionarioModel funcionario;
  Authority authority;

  FuncionarioDto({
    required this.funcionario,
    required this.authority,
  });
}
