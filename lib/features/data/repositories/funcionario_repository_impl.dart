import 'package:app/features/data/datasources/funcionario_remote_datasource.dart';
import 'package:app/features/domain/entities/funcionario.dart';
import 'package:app/features/data/models/funcionario_model.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/repositories/funcionario_repository.dart';
import 'package:dartz/dartz.dart';

class FuncionarioRepositoryImpl implements FuncionarioRepository {
  final FuncionarioRemoteDatasource _datasource;

  FuncionarioRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, Funcionario>> addFuncionario(Funcionario funcionario) async {
    try {
      final result = await _datasource.cadastrarFuncionario(funcionario as FuncionarioModel);

      return Right(result as Funcionario);
    } on Failure catch (e) {
      return left(e);
    }
  }
}
