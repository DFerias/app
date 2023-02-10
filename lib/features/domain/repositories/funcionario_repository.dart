import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/entities/funcionario.dart';
import 'package:dartz/dartz.dart';

abstract class FuncionarioRepository {
  Future<Either<Failure, Funcionario>> addFuncionario(Funcionario funcionario);
}
