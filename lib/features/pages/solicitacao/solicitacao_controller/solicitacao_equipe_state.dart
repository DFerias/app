part of 'solicitacao_equipe_controller.dart';

enum SolicitacaoEquipeStatus {
  initial,
  loading,
  loaded,
  success,
  error,
}

class SolicitacaoEquipeState extends Equatable {
  final SolicitacaoEquipeStatus status;
  final List<SolicitacaoFeriasDto>? solFerias;
  final String? successMessage;
  final String? errorMessage;

  const SolicitacaoEquipeState(
    this.status,
    this.solFerias,
    this.successMessage,
    this.errorMessage,
  );

  SolicitacaoEquipeState.initial()
      : status = SolicitacaoEquipeStatus.initial,
        solFerias = [],
        successMessage = null,
        errorMessage = null;

  @override
  List<Object?> get props => [
        status,
        solFerias,
        successMessage,
        errorMessage,
      ];

  SolicitacaoEquipeState copyWith({
    SolicitacaoEquipeStatus? status,
    List<SolicitacaoFeriasDto>? solFerias,
    String? successMessage,
    String? errorMessage,
  }) {
    return SolicitacaoEquipeState(
      status ?? this.status,
      solFerias ?? this.solFerias,
      successMessage ?? this.successMessage,
      errorMessage ?? this.errorMessage,
    );
  }
}
