import 'package:app/core/errors/failure.dart';
import 'package:app/features/data/dto/solicitacao_ferias_dto.dart';
import 'package:app/features/domain/entities/ferias.dart';
import 'package:dartz/dartz.dart';

abstract class FeriasRepository {
  Future<Either<Failure, List<SolicitacaoFeriasDto>>> getFerias();
  Future<Either<Failure, List<Ferias>>> getHistoricoFerias(id);
  Future<Either<Failure, String>> changeStatusFerias(idSolicitacao, status);
  Future<Either<Failure, List<SolicitacaoFeriasDto>>> getFeriasEquipe();
  Future<Either<Failure, String>> addFerias(ferias);
}
