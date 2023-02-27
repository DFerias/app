import 'package:app/features/data/dto/solicitacao_ferias_dto.dart';
import 'package:app/features/domain/entities/equipe.dart';
import 'package:app/features/domain/usecases/equipe_usecase.dart';
import 'package:app/features/domain/usecases/ferias_usecase.dart';
import 'package:app/core/injections/injection.dart' as di;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'listar_ferias_event.dart';
part 'listar_ferias_state.dart';

class ListarFeriasController extends Cubit<ListarFeriasState> {
  int page = 1;
  bool carregando = false;
  bool continuarCarregando = true;
  bool refresh = false;

  ListarFeriasController() : super(ListarFeriasState.initial());

  Future<void> loadFerias() async {
    emit(state.copyWith(status: ListaFeriasStatus.loading));
    final getFerias = di.getIt<GetFeriasUsecase>();
    final getEquipes = di.getIt<GetEquipesUseCase>();

    try {
      final ferias = await getFerias.call();
      final equipes = await getEquipes.call();

      ferias.fold(
        (l) => emit(state.copyWith(status: ListaFeriasStatus.error, errorMessage: l.message)),
        (r) => emit(state.copyWith(status: ListaFeriasStatus.loaded, ferias: r)),
      );

      equipes.fold(
        (l) => emit(state.copyWith(status: ListaFeriasStatus.error, errorMessage: l.message)),
        (r) => emit(state.copyWith(status: ListaFeriasStatus.loaded, equipes: r)),
      );
    } catch (e) {
      emit(
        state.copyWith(status: ListaFeriasStatus.error, errorMessage: e.toString()),
      );
    }
  }
}
