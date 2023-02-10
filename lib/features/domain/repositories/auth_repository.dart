import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/entities/auth.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, Auth>> auth(String email, String password);
}
