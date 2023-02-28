import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/entities/funcionario.dart';
import 'package:app/features/domain/repositories/funcionario_repository.dart';
import 'package:dartz/dartz.dart';

class AddFuncionarioUsecase {
  final FuncionarioRepository _repository;

  AddFuncionarioUsecase(this._repository);

  Future<Either<Failure, String>> call(Funcionario funcionario) async => _repository.addFuncionario(funcionario);
}

class ListarFuncionariosUsecase {
  final FuncionarioRepository _repository;

  ListarFuncionariosUsecase(this._repository);

  Future<Either<Failure, List<Funcionario>>> call() async => _repository.getFuncionarios();
}
