import 'package:app/features/domain/entities/auth.dart';
import 'package:app/features/domain/usecases/auth_usecase.dart';
import 'package:bloc/bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class AuthController extends Cubit<AuthState> {
  final AuthUsecase _usecase;

  AuthController(
    this._usecase,
  ) : super(AuthInitial());

  Future<void> auth(String email, String password) async {
    try {
      emit(AuthLoading());

      var teste = _usecase.call(email, password);
    } catch (e) {
      emit(AuthInitial());
    }
  }

  /* {
    on<LoginEvent>((event, emit) async {
      if (event.email!.isEmpty || event.password!.isEmpty) {
        emit(AuthError('Ocorreu um erro, verifique e tente novamente!'));
      } else {
        /* emit(AuthLoading());
        final data = await authRepository.login(event.email!, event.password!);

        if (data is Auth) {
          App.authService.atualizarSessao(token: data.token, usuario: data.funcionario);
          emit(AuthSucess(data));
        } else {
          emit(AuthInitial());
        } */
      }
    });
  } */
}
