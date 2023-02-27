import 'package:app/features/domain/entities/auth.dart';
import 'package:app/features/domain/usecases/auth_usecase.dart';
import 'package:app/core/injections/injection.dart' as di;
import 'package:app/index.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class AuthController extends Cubit<AuthState> {
  AuthController() : super(const AuthState.initial());

  Future<void> auth(String email, String password) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      final useCase = di.getIt<AuthUsecase>();

      var result = await useCase.call(email, password);

      result.fold(
        (l) => emit(state.copyWith(status: AuthStatus.error, errorMessage: l.message)),
        (r) {
          App.authService.atualizarSessao(
            token: r.token,
            usuario: r.funcionario,
            isLider: r.isLider,
            authRh: r.authority?.any((element) => element.authority?.contains('RH') ?? false),
          );
          emit(state.copyWith(status: AuthStatus.success, auth: r));
        },
      );
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
  }
}
