import 'package:bloc/bloc.dart';

part 'listar_ferias_event.dart';
part 'listar_ferias_state.dart';

class ListarFeriasBloc extends Bloc<ListarFeriasEvent, ListarFeriasState> {
  static final ListarFeriasBloc instance = ListarFeriasBloc();

  final _listarFeriasRepo = ListarFeriasRepository();
  int page = 1;
  bool carregando = false;
  bool continuarCarregando = true;
  bool refresh = false;

  List<SolicitacaoFeriasModel> listaGeral = [];

  ListarFeriasBloc() : super(ListarFeriasInitialState()) {
    on<LoadListEvent>((event, emit) async {
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
    });
  }
}
