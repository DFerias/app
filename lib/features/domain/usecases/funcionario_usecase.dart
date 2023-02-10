import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/entities/funcionario.dart';
import 'package:app/features/domain/repositories/funcionario_repository.dart';
import 'package:dartz/dartz.dart';

class FuncionarioUsecase {
  final FuncionarioRepository _repository;

  FuncionarioUsecase(this._repository);

  Future<Either<Failure, Funcionario>> call(Funcionario funcionario) async => _repository.addFuncionario(funcionario);
}
