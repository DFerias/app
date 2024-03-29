import 'package:app/features/domain/entities/equipe.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/repositories/equipe_repository.dart';
import 'package:app/index.dart';
import 'package:dartz/dartz.dart';

class EquipeRepositoryImpl extends EquipeRepository {
  final EquipeRemoteDatasource _datasource;

  EquipeRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, Equipe>> addEquipe(Equipe equipe) async {
    try {
      final result = await _datasource.cadastrarEquipe(equipe);

      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<Equipe>>> getEquipes() async {
    try {
      final result = await _datasource.getEquipes();

      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
