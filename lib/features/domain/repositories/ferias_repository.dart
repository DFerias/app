import 'package:app/core/errors/failure.dart';
import 'package:app/features/data/dto/solicitacao_ferias_dto.dart';
import 'package:dartz/dartz.dart';

abstract class FeriasRepository {
  Future<Either<Failure, List<SolicitacaoFeriasDto>>> getFerias();
  Future<Either<Failure, String>> addFerias(ferias);
}
