import 'package:app/core/errors/failure.dart';
import 'package:app/features/domain/entities/ferias.dart';
import 'package:app/features/domain/usecases/ferias_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/core/injections/injection.dart' as di;

part 'solicitacao_state.dart';

class SolicitacaoController extends Cubit<SolicitacaoState> {
  SolicitacaoController() : super(const SolicitacaoState.initial());

  Future<void> addSolicitacao(Ferias ferias) async {
    emit(state.copyWith(status: SolicitacaoStatus.loading));

    try {
      final addSolicitacao = di.getIt<AddFeriasUsecase>();

      final response = await addSolicitacao.call(ferias);

      response.fold(
        (l) => emit(state.copyWith(status: SolicitacaoStatus.error, errorMessage: l.message)),
        (r) => emit(state.copyWith(status: SolicitacaoStatus.success, ferias: r)),
      );
    } on Failure catch (e) {
      emit(state.copyWith(status: SolicitacaoStatus.error, errorMessage: e.message));
    }
  }
}
