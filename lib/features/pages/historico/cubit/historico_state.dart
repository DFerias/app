part of 'historico_controller.dart';

enum HistoricoStatus {
  initial,
  loading,
  loaded,
  error;
}

class HistoricoState extends Equatable {
  final HistoricoStatus status;
  final List<Ferias>? listaTodos;
  final List<Ferias>? listaRejeitados;
  final List<Ferias>? listaAprovados;
  final String? errorMessage;

  const HistoricoState(
    this.status,
    this.listaTodos,
    this.listaRejeitados,
    this.listaAprovados,
    this.errorMessage,
  );

  HistoricoState.initial()
      : status = HistoricoStatus.initial,
        listaTodos = [],
        listaRejeitados = [],
        listaAprovados = [],
        errorMessage = null;

  @override
  List<Object?> get props => [
        status,
        listaTodos,
        listaRejeitados,
        listaAprovados,
        errorMessage,
      ];

  HistoricoState copyWith({
    HistoricoStatus? status,
    List<Ferias>? listaTodos,
    List<Ferias>? listaRejeitados,
    List<Ferias>? listaAprovados,
    String? errorMessage,
  }) {
    return HistoricoState(
      status ?? this.status,
      listaTodos ?? this.listaTodos,
      listaRejeitados ?? this.listaRejeitados,
      listaAprovados ?? this.listaAprovados,
      errorMessage ?? this.errorMessage,
    );
  }
}
