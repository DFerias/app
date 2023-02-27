import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/entities/equipe.dart';
import 'package:app/features/domain/repositories/equipe_repository.dart';
import 'package:dartz/dartz.dart';

class AddEquipeUseCase {
  final EquipeRepository _repository;

  AddEquipeUseCase(this._repository);

  Future<Either<Failure, Equipe>> call(Equipe equipe) async => _repository.addEquipe(equipe);
}

class GetEquipesUseCase {
  final EquipeRepository _repository;

  GetEquipesUseCase(this._repository);

  Future<Either<Failure, List<Equipe>>> call() async => _repository.getEquipes();
}
