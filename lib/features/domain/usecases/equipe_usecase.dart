import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/entities/equipe.dart';
import 'package:app/features/domain/repositories/equipe_repository.dart';
import 'package:dartz/dartz.dart';

class EquipeUsecase {
  final EquipeRepository _repository;

  EquipeUsecase(this._repository);

  Future<Either<Failure, Equipe>> call(Equipe equipe) => _repository.addEquipe(equipe);
}
