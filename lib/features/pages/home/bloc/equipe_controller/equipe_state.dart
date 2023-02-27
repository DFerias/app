part of 'equipe_controller.dart';

enum EquipeStatus {
  initial,
  loading,
  loaded,
  error,
}

class EquipeState extends Equatable {
  final EquipeStatus status;
  final List<Equipe> equipes;
  final Equipe? equipe;
  final String? errorMessage;

  const EquipeState(
    this.status,
    this.equipes,
    this.equipe,
    this.errorMessage,
  );

  EquipeState.initial()
      : status = EquipeStatus.initial,
        equipes = [],
        equipe = null,
        errorMessage = null;

  @override
  List<Object?> get props => [
        status,
        equipes,
        equipe,
        errorMessage,
      ];

  EquipeState copyWith({
    EquipeStatus? status,
    List<Equipe>? equipes,
    Equipe? equipe,
    String? errorMessage,
  }) {
    return EquipeState(
      status ?? this.status,
      equipes ?? this.equipes,
      equipe ?? this.equipe,
      errorMessage ?? this.errorMessage,
    );
  }
}
