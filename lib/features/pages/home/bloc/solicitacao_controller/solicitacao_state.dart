part of 'solicitacao_controller.dart';

enum SolicitacaoStatus {
  initial,
  loading,
  success,
  error,
}

class SolicitacaoState extends Equatable {
  final SolicitacaoStatus? status;
  final Ferias? ferias;
  final DateTime? dataInicial;
  final DateTime? dataFinal;
  final String? errorMessage;

  const SolicitacaoState(
    this.status,
    this.ferias,
    this.dataInicial,
    this.dataFinal,
    this.errorMessage,
  );

  const SolicitacaoState.initial()
      : status = SolicitacaoStatus.initial,
        ferias = null,
        dataInicial = null,
        dataFinal = null,
        errorMessage = null;

  @override
  List<Object?> get props => [];

  SolicitacaoState copyWith({
    SolicitacaoStatus? status,
    Ferias? ferias,
    DateTime? dataInicial,
    DateTime? dataFinal,
    String? errorMessage,
  }) {
    return SolicitacaoState(
      status ?? this.status,
      ferias ?? this.ferias,
      dataInicial ?? this.dataInicial,
      dataFinal ?? this.dataFinal,
      errorMessage ?? this.errorMessage,
    );
  }
}
