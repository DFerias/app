import 'package:app/core/errors/failure.dart';
import 'package:app/features/data/dto/solicitacao_ferias_dto.dart';
import 'package:app/features/domain/entities/ferias.dart';
import 'package:app/features/domain/repositories/ferias_repository.dart';
import 'package:dartz/dartz.dart';

class GetFeriasUseCase {
  final FeriasRepository _repository;

  GetFeriasUseCase(this._repository);

  Future<Either<Failure, List<SolicitacaoFeriasDto>>> call() async => _repository.getFerias();
}

class AddFeriasUseCase {
  final FeriasRepository _repository;

  AddFeriasUseCase(this._repository);

  Future<Either<Failure, Ferias>> call(Ferias ferias) async => _repository.addFerias(ferias);
}
