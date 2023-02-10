import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/entities/modalidade.dart';
import 'package:app/features/domain/repositories/modalidade_repository.dart';
import 'package:dartz/dartz.dart';

class ModalidadeUsecase {
  final ModalidadeRepository _repository;

  ModalidadeUsecase(this._repository);

  Future<Either<Failure, List<Modalidade>>> call() async => _repository.getModalidades();
}
