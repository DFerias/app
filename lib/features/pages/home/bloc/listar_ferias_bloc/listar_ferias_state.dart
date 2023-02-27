part of 'listar_ferias_bloc.dart';

enum ListaFeriasStatus {
  initial,
  loading,
  refresh,
  loaded,
  error;
}

class ListarFeriasState extends Equatable {
  final ListaFeriasStatus status;
  final List<SolicitacaoFeriasDto> ferias;
  final List<Equipe> equipes;
  final bool carregando;
  final bool continuarCarregando;
  final String? errorMessage;

  const ListarFeriasState(
    this.status,
    this.ferias,
    this.equipes,
    this.carregando,
    this.continuarCarregando,
    this.errorMessage,
  );

  ListarFeriasState.initial()
      : status = ListaFeriasStatus.initial,
        ferias = [],
        equipes = [],
        carregando = false,
        continuarCarregando = true,
        errorMessage = null;

  @override
  List<Object?> get props => [status, ferias, equipes, carregando, continuarCarregando, errorMessage];

  ListarFeriasState copyWith({
    ListaFeriasStatus? status,
    List<SolicitacaoFeriasDto>? ferias,
    List<Equipe>? equipes,
    bool? carregando,
    bool? continuarCarregando,
    String? errorMessage,
  }) {
    return ListarFeriasState(
      status ?? this.status,
      ferias ?? this.ferias,
      equipes ?? this.equipes,
      carregando ?? this.carregando,
      continuarCarregando ?? this.continuarCarregando,
      errorMessage ?? this.errorMessage,
    );
  }
}
