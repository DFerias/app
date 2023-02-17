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

class AddFeriasUsecase {
  final FeriasRepository _repository;

  AddFeriasUsecase(this._repository);

  Future<Either<Failure, String>> call(Ferias ferias) async => _repository.addFerias(ferias);
}
