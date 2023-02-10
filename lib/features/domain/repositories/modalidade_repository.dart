import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/entities/modalidade.dart';
import 'package:dartz/dartz.dart';

abstract class ModalidadeRepository {
  Future<Either<Failure, List<Modalidade>>> getModalidades();
}
