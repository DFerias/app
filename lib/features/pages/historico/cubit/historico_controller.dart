import 'package:app/core/injections/injection.dart' as di;
import 'package:app/features/domain/entities/ferias.dart';
import 'package:app/features/domain/usecases/ferias_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'historico_state.dart';

class HistoricoController extends Cubit<HistoricoState> {
  HistoricoController() : super(HistoricoState.initial());

  Future<void> loadAllFerias(int idFuncionario) async {
    emit(state.copyWith(status: HistoricoStatus.loading));
    try {
      final getFerias = di.getIt<GetHistoricoFerias>();

      await getFerias.call(idFuncionario).then((result) {
        result.fold(
          (l) => emit(state.copyWith(status: HistoricoStatus.error, errorMessage: l.message)),
          (r) => emit(
            state.copyWith(
              status: HistoricoStatus.loaded,
              listaTodos: r,
              listaRejeitados: r.where((e) => e.status == 'RECUSADA').toList(),
              listaAprovados: r.where((e) => e.status == 'APROVADA').toList(),
            ),
          ),
        );
      });
    } catch (e) {
      emit(state.copyWith(status: HistoricoStatus.error, errorMessage: e.toString()));
    }
  }
}
