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
  final List<SolicitacaoFeriasDto>? solFeriasTodos;
  final String? successMessage;
  final String? errorMessage;

  const SolicitacaoEquipeState(
    this.status,
    this.solFerias,
    this.solFeriasTodos,
    this.successMessage,
    this.errorMessage,
  );

  SolicitacaoEquipeState.initial()
      : status = SolicitacaoEquipeStatus.initial,
        solFerias = [],
        solFeriasTodos = [],
        successMessage = null,
        errorMessage = null;

  @override
  List<Object?> get props => [
        status,
        solFerias,
        solFeriasTodos,
        successMessage,
        errorMessage,
      ];

  SolicitacaoEquipeState copyWith({
    SolicitacaoEquipeStatus? status,
    List<SolicitacaoFeriasDto>? solFerias,
    List<SolicitacaoFeriasDto>? solFeriasTodos,
    String? successMessage,
    String? errorMessage,
  }) {
    return SolicitacaoEquipeState(
      status ?? this.status,
      solFerias ?? this.solFerias,
      solFeriasTodos ?? this.solFeriasTodos,
      successMessage ?? this.successMessage,
      errorMessage ?? this.errorMessage,
    );
  }
}
