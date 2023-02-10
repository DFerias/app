import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/entities/auth.dart';
import 'package:app/features/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthUsecase {
  final AuthRepository _repository;

  AuthUsecase(this._repository);

  Future<Future<Either<Failure, Auth>>> call(String email, String password) async => _repository.auth(email, password);
}
