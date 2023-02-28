import 'package:app/features/domain/entities/equipe.dart';
import 'package:app/features/domain/usecases/equipe_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/core/injections/injection.dart' as di;

part 'equipe_state.dart';

class EquipeController extends Cubit<EquipeState> {
  EquipeController() : super(EquipeState.initial());

  Future<void> addEquipe(String idLider, String nomeEquipe, String cor) async {
    emit(state.copyWith(status: EquipeStatus.loading));

    final addEquipes = di.getIt<AddEquipeUseCase>();

    try {
      final newEquipe = await addEquipes.call(
        Equipe(idLider: int.parse(idLider), nome: nomeEquipe, cor: cor.replaceAll('Color(0xff', '#').replaceAll(')', '')),
      );

      newEquipe.fold(
        (l) => emit(state.copyWith(status: EquipeStatus.error, errorMessage: l.message)),
        (r) => emit(state.copyWith(status: EquipeStatus.loaded, equipe: r)),
      );
    } catch (e) {
      emit(state.copyWith(status: EquipeStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getEquipes() async {
    emit(state.copyWith(status: EquipeStatus.loading));

    try {
      final getEquipes = di.getIt<GetEquipesUseCase>();
      final equipes = await getEquipes.call();

      equipes.fold(
        (l) => emit(state.copyWith(status: EquipeStatus.error, errorMessage: l.message)),
        (r) => emit(state.copyWith(status: EquipeStatus.loaded, equipes: r)),
      );
    } catch (e) {
      emit(state.copyWith(status: EquipeStatus.error, errorMessage: e.toString()));
    }
  }
}
