import 'package:app/features/data/dto/solicitacao_ferias_dto.dart';
import 'package:app/core/injections/injection.dart' as di;
import 'package:app/features/domain/usecases/ferias_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'solicitacao_equipe_state.dart';

class SolicitacaoEquipeController extends Cubit<SolicitacaoEquipeState> {
  SolicitacaoEquipeController() : super(SolicitacaoEquipeState.initial());

  Future<void> loadFeriasEquipe() async {
    emit(state.copyWith(status: SolicitacaoEquipeStatus.loading));

    try {
      final getFeriasEquipe = di.getIt<GetFeriasEquipeUseCase>();

      await getFeriasEquipe.call().then(
            (solFerias) => solFerias.fold(
              (l) => emit(state.copyWith(status: SolicitacaoEquipeStatus.error, errorMessage: l.message)),
              (r) => emit(state.copyWith(status: SolicitacaoEquipeStatus.loaded, solFerias: r.where((e) => e.ferias?.status == 'PENDENTE').toList())),
            ),
          );
    } catch (e) {
      emit(state.copyWith(status: SolicitacaoEquipeStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> loadFeriasValidadas() async {
    emit(state.copyWith(status: SolicitacaoEquipeStatus.loading));

    try {
      final getFeriasEquipe = di.getIt<GerFeriasValidadasUseCase>();

      await getFeriasEquipe.call().then(
            (solFerias) => solFerias.fold(
              (l) => emit(state.copyWith(status: SolicitacaoEquipeStatus.error, errorMessage: l.message)),
              (r) => emit(state.copyWith(status: SolicitacaoEquipeStatus.loaded, solFeriasTodos: r)),
            ),
          );
    } catch (e) {
      emit(state.copyWith(status: SolicitacaoEquipeStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> changeStatusFeriasEquipe(int idSolicitacao, String status, String? comentario, bool isRh) async {
    emit(state.copyWith(status: SolicitacaoEquipeStatus.loading));

    String? comentLider;
    String? comentRh;

    if (isRh) {
      comentLider = null;
      comentRh = comentario;
    } else {
      comentLider = comentario;
      comentRh = null;
    }

    try {
      final changeStatusFerias = di.getIt<ChangeStatusFeriasUseCase>();

      await changeStatusFerias.call(idSolicitacao, status, comentarioLider: comentLider, comentarioRh: comentRh).then(
            (result) => result.fold(
              (l) => emit(state.copyWith(status: SolicitacaoEquipeStatus.error, errorMessage: l.message)),
              (r) => emit(state.copyWith(status: SolicitacaoEquipeStatus.success, successMessage: r)),
            ),
          );
    } catch (e) {
      emit(state.copyWith(status: SolicitacaoEquipeStatus.error, errorMessage: e.toString()));
    }
  }
}
