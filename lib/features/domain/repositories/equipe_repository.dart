import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/entities/equipe.dart';
import 'package:dartz/dartz.dart';

abstract class EquipeRepository {
  Future<Either<Failure, Equipe>> addEquipe(Equipe equipe);
  Future<Either<Failure, List<Equipe>>> getEquipes();
}
