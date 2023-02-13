import 'package:app/features/data/dto/solicitacao_ferias_dto.dart';
import 'package:app/features/domain/usecases/ferias_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'listar_ferias_event.dart';
part 'listar_ferias_state.dart';

class ListarFeriasController extends Cubit<ListarFeriasState> {
  int page = 1;
  bool carregando = false;
  bool continuarCarregando = true;
  bool refresh = false;

  final GetFeriasUsecase _usecase;

  ListarFeriasController(this._usecase) : super(ListarFeriasState.initial());

  Future<void> loadFerias() async {
    emit(state.copyWith(status: ListaFeriasStatus.loading));
    try {
      _usecase.call().then((ferias) {
        ferias.fold(
          (l) => emit(state.copyWith(status: ListaFeriasStatus.error, errorMessage: l.message)),
          (r) => emit(state.copyWith(status: ListaFeriasStatus.loaded, ferias: r)),
        );
      });
    } catch (e) {
      emit(
        state.copyWith(status: ListaFeriasStatus.error, errorMessage: e.toString()),
      );
    }
  }

  /* ListarFeriasController(this._usecase) : super(ListarFeriasState.initial()) {
    

    /*  on<LoadListEvent>((event, emit) async {
      emit(LoadingListState());

      List<SolicitacaoFeriasModel> dados = await _listarFeriasRepo.listarFeriasGeralRepo();
      continuarCarregando = dados.length >= 25;
      page++;

      listaGeral.addAll(dados);

      emit(SuccessListState());
    });

    on<RefreshListEvent>((event, emit) async {
      emit(RefreshListState());
      page = 1;

      List<SolicitacaoFeriasModel> dados = await _listarFeriasRepo.listarFeriasGeralRepo();
      continuarCarregando = dados.length >= 25;
      page++;

      listaGeral = dados;

      emit(SuccessListState());
    }); */
  } */
}
