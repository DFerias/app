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
  final bool carregando;
  final bool continuarCarregando;
  final String? errorMessage;

  const ListarFeriasState(
    this.status,
    this.ferias,
    this.carregando,
    this.continuarCarregando,
    this.errorMessage,
  );

  ListarFeriasState.initial()
      : status = ListaFeriasStatus.initial,
        ferias = [],
        carregando = false,
        continuarCarregando = true,
        errorMessage = null;

  @override
  List<Object?> get props => [status, ferias, errorMessage];

  ListarFeriasState copyWith({
    ListaFeriasStatus? status,
    List<SolicitacaoFeriasDto>? ferias,
    bool? carregando,
    bool? continuarCarregando,
    String? errorMessage,
  }) {
    return ListarFeriasState(
      status ?? this.status,
      ferias ?? this.ferias,
      carregando ?? this.carregando,
      continuarCarregando ?? this.continuarCarregando,
      errorMessage ?? this.errorMessage,
    );
  }
}
