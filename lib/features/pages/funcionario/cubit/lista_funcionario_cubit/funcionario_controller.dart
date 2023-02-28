import 'package:app/index.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/core/injections/injection.dart' as di;

part 'funcionario_state.dart';

class FuncionarioController extends Cubit<FuncionarioState> {
  FuncionarioController() : super(FuncionarioState.initial());

  Future<void> getFuncionarios() async {
    emit(state.copyWith(status: FuncionarioStatus.loading));

    try {
      final getFuncionarios = di.getIt<ListarFuncionariosUsecase>();

      await getFuncionarios.call().then((funcionarios) {
        funcionarios.fold(
          (l) => emit(state.copyWith(status: FuncionarioStatus.error, errorMessage: l.message)),
          (r) => emit(state.copyWith(status: FuncionarioStatus.loaded, funcionarios: r)),
        );
      });
    } catch (e) {
      emit(state.copyWith(status: FuncionarioStatus.error, errorMessage: e.toString()));
    }
  }
}