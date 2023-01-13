import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/index.dart';
import 'package:bloc/bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static final AuthBloc instance = AuthBloc();
  AuthRepository authRepository = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event.email!.isEmpty || event.password!.isEmpty) {
        emit(AuthError('Ocorreu um erro, verifique e tente novamente!'));
      } else {
        emit(AuthLoading());
        final data = await authRepository.login(event.email!, event.password!);

        if (data is AuthModel) {
          App.authService.atualizarSessao(token: data.token);
          emit(AuthSucess(data));
        } else {
          emit(AuthInitial());
        }
      }
    });
  }
}
