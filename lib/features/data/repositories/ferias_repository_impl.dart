import 'package:app/features/data/dto/solicitacao_ferias_dto.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/repositories/ferias_repository.dart';
import 'package:app/index.dart';
import 'package:dartz/dartz.dart';

class FeriasRepositoryImpl implements FeriasRepository {
  final FeriasRemoteDatasource _datasource;

  FeriasRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<SolicitacaoFeriasDto>>> getFerias() async {
    try {
      final result = await _datasource.listarFeriasGeral();

      return Right(result as List<SolicitacaoFeriasDto>);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, String>> addFerias(ferias) async {
    try {
      final result = await _datasource.cadastrarFerias(ferias);

      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
