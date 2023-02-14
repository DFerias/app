import 'package:app/features/data/datasources/auth_remote_datasource.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/entities/auth.dart';
import 'package:app/features/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, Auth>> authLogin(String email, String password) async {
    try {
      final result = await authRemoteDatasource.login(email, password);

      return Right(result);
    } on Failure catch (e) {
      return left(e);
    }
  }
}
