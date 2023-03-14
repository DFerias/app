import 'package:app/core/errors/failure.dart';
import 'package:app/features/data/dto/solicitacao_ferias_dto.dart';
import 'package:app/features/domain/entities/ferias.dart';
import 'package:app/features/domain/repositories/ferias_repository.dart';
import 'package:dartz/dartz.dart';

class GetFeriasUsecase {
  final FeriasRepository _repository;

  GetFeriasUsecase(this._repository);

  Future<Either<Failure, List<SolicitacaoFeriasDto>>> call() async => _repository.getFerias();
}

class GetHistoricoFerias {
  final FeriasRepository _repository;

  GetHistoricoFerias(this._repository);

  Future<Either<Failure, List<Ferias>>> call(int id) async => _repository.getHistoricoFerias(id);
}

class ChangeStatusFeriasUseCase {
  final FeriasRepository _repository;

  ChangeStatusFeriasUseCase(this._repository);

  Future<Either<Failure, String>> call(
    int idSolicitacao,
    String status, {
    String? comentarioLider,
    String? comentarioRh,
  }) async =>
      _repository.changeStatusFerias(
        idSolicitacao,
        status,
        comentarioLider: comentarioLider,
        comentarioRh: comentarioRh,
      );
}

class GetFeriasEquipeUseCase {
  final FeriasRepository _repository;

  GetFeriasEquipeUseCase(this._repository);

  Future<Either<Failure, List<SolicitacaoFeriasDto>>> call() async => _repository.getFeriasEquipe();
}

class GerFeriasValidadasUseCase {
  final FeriasRepository _repository;

  GerFeriasValidadasUseCase(this._repository);

  Future<Either<Failure, List<SolicitacaoFeriasDto>>> call() async => _repository.getFeriasValidadas();
}

class AddFeriasUsecase {
  final FeriasRepository _repository;

  AddFeriasUsecase(this._repository);

  Future<Either<Failure, String>> call(Ferias ferias) async => _repository.addFerias(ferias);
}
