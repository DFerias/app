import 'package:app/features/data/datasources/modalidade_remote_datasource.dart';
import 'package:app/features/domain/entities/modalidade.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/repositories/modalidade_repository.dart';
import 'package:dartz/dartz.dart';

class ModalidadeRepositoryImpl extends ModalidadeRepository {
  final ModalidadeRemoteDatasource _datasource;

  ModalidadeRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<Modalidade>>> getModalidades() async {
    try {
      final result = await _datasource.listarModalidade();

      return Right(result as List<Modalidade>);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
