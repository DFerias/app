import 'package:app/features/data/datasources/auth_remote_datasource.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/entities/auth.dart';
import 'package:app/features/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRepositoryImpl(this._authRemoteDatasource);

  @override
  Future<Either<Failure, Auth>> auth(String email, String password) async {
    try {
      final result = await _authRemoteDatasource.login(email, password);

      return Right(result as Auth);
    } on Failure catch (e) {
      return left(e);
    }
  }
}
