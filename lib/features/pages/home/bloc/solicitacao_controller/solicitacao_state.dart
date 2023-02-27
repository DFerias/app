part of 'solicitacao_controller.dart';

enum SolicitacaoStatus {
  initial,
  loading,
  success,
  error,
}

class SolicitacaoState extends Equatable {
  final SolicitacaoStatus? status;
  final String? successMessage;
  final DateTime? dataInicial;
  final DateTime? dataFinal;
  final String? errorMessage;

  const SolicitacaoState(
    this.status,
    this.successMessage,
    this.dataInicial,
    this.dataFinal,
    this.errorMessage,
  );

  const SolicitacaoState.initial()
      : status = SolicitacaoStatus.initial,
        successMessage = null,
        dataInicial = null,
        dataFinal = null,
        errorMessage = null;

  @override
  List<Object?> get props => [
        status,
        successMessage,
        dataInicial,
        dataFinal,
        errorMessage,
      ];

  SolicitacaoState copyWith({
    SolicitacaoStatus? status,
    String? successMessage,
    DateTime? dataInicial,
    DateTime? dataFinal,
    String? errorMessage,
  }) {
    return SolicitacaoState(
      status ?? this.status,
      successMessage ?? this.successMessage,
      dataInicial ?? this.dataInicial,
      dataFinal ?? this.dataFinal,
      errorMessage ?? this.errorMessage,
    );
  }
}
