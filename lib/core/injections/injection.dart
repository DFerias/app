import 'package:app/core/client/client.dart';
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
import 'package:http/http.dart' as http;
import 'package:app/index.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authRemoteDatasource: getIt<AuthRemoteDatasource>()));
  getIt.registerLazySingleton<EquipeRepository>(() => EquipeRepositoryImpl(getIt<EquipeRemoteDatasource>()));
  getIt.registerLazySingleton<FeriasRepository>(() => FeriasRepositoryImpl(getIt<FeriasRemoteDatasource>()));
  getIt.registerLazySingleton<FuncionarioRepository>(() => FuncionarioRepositoryImpl(getIt<FuncionarioRemoteDatasource>()));
  getIt.registerLazySingleton<ModalidadeRepository>(() => ModalidadeRepositoryImpl(getIt<ModalidadeRemoteDatasource>()));

  //usecases
  getIt.registerLazySingleton(() => AuthUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => AddEquipeUseCase(getIt<EquipeRepository>()));
  getIt.registerLazySingleton(() => GetEquipesUseCase(getIt<EquipeRepository>()));
  getIt.registerLazySingleton(() => GetFeriasUsecase(getIt<FeriasRepository>()));
  getIt.registerLazySingleton(() => GetHistoricoFerias(getIt<FeriasRepository>()));
  getIt.registerLazySingleton(() => ChangeStatusFeriasUseCase(getIt<FeriasRepository>()));
  getIt.registerLazySingleton(() => GetFeriasEquipeUseCase(getIt<FeriasRepository>()));
  getIt.registerLazySingleton(() => GerFeriasValidadasUseCase(getIt<FeriasRepository>()));
  getIt.registerLazySingleton(() => AddFeriasUsecase(getIt<FeriasRepository>()));
  getIt.registerLazySingleton(() => ListarFuncionariosUsecase(getIt<FuncionarioRepository>()));
  getIt.registerLazySingleton(() => AddFuncionarioUsecase(getIt<FuncionarioRepository>()));
  getIt.registerLazySingleton(() => ModalidadeUsecase(getIt<ModalidadeRepository>()));

  //Datasources
  getIt.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(getIt()));
  getIt.registerLazySingleton<EquipeRemoteDatasource>(() => EquipeRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<FeriasRemoteDatasource>(() => FeriasRemoteDatasourceImpl(getIt()));
  getIt.registerLazySingleton<FuncionarioRemoteDatasource>(() => FuncionarioRemoteDatasourceImpl(client: getIt()));
  getIt.registerLazySingleton<ModalidadeRemoteDatasource>(() => ModalidadeRemoteDatasourceImpl());

  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton<Client>(() => Client());

  //controller
  // getIt.registerLazySingleton<ListarFeriasController>(() => ListarFeriasController(getIt()));
}
