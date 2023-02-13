import 'package:app/features/data/datasources/funcionario_remote_datasource.dart';
import 'package:app/features/data/repositories/auth_repository_impl.dart';
import 'package:app/features/data/repositories/modalidades_repository_impl.dart';
import 'package:app/features/domain/repositories/auth_repository.dart';
import 'package:app/features/domain/repositories/equipe_repository.dart';
import 'package:app/features/domain/repositories/ferias_repository.dart';
import 'package:app/features/domain/repositories/funcionario_repository.dart';
import 'package:app/features/domain/repositories/modalidade_repository.dart';
import 'package:app/features/domain/usecases/auth_usecase.dart';
import 'package:app/features/domain/usecases/equipe_usecase.dart';
import 'package:app/features/domain/usecases/ferias_usecase.dart';
import 'package:app/features/domain/usecases/funcionario_usecase.dart';
import 'package:app/features/domain/usecases/modalidade_usecase.dart';
import 'package:app/index.dart';
import 'package:get_it/get_it.dart';

class Injection {
  GetIt getIt = GetIt.instance;

  Future<void> init() async {
    //Datasources
    getIt.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(client: getIt()));
    getIt.registerLazySingleton<EquipeRemoteDatasource>(() => EquipeRemoteDataSourceImpl(client: getIt()));
    getIt.registerLazySingleton<FeriasRemoteDatasource>(() => FeriasRemoteDatasourceImpl());
    getIt.registerLazySingleton<FuncionarioRemoteDatasource>(() => FuncionarioRemoteDatasourceImpl(client: getIt()));
    getIt.registerLazySingleton<ModalidadeRemoteDatasource>(() => ModalidadeRemoteDatasourceImpl());

    //Repositories
    getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()));
    getIt.registerLazySingleton<EquipeRepository>(() => EquipeRepositoryImpl(getIt()));
    getIt.registerLazySingleton<FeriasRepository>(() => FeriasRepositoryImpl(getIt()));
    getIt.registerLazySingleton<FuncionarioRepository>(() => FuncionarioRepositoryImpl(getIt()));
    getIt.registerLazySingleton<ModalidadeRepository>(() => ModalidadeRepositoryImpl(getIt()));

    //usecases
    getIt.registerLazySingleton<AuthUsecase>(() => AuthUsecase(getIt()));
    getIt.registerLazySingleton<EquipeUsecase>(() => EquipeUsecase(getIt()));
    getIt.registerLazySingleton<GetFeriasUsecase>(() => GetFeriasUsecase(getIt()));
    getIt.registerLazySingleton<AddFeriasUsecase>(() => AddFeriasUsecase(getIt()));
    getIt.registerLazySingleton<FuncionarioUsecase>(() => FuncionarioUsecase(getIt()));
    getIt.registerLazySingleton<ModalidadeUsecase>(() => ModalidadeUsecase(getIt()));

    //controller
    // getIt.registerLazySingleton<ListarFeriasController>(() => ListarFeriasController(getIt()));
  }
}
