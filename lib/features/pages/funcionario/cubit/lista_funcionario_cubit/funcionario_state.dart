part of 'funcionario_controller.dart';

enum FuncionarioStatus {
  initial,
  loading,
  loaded,
  error;
}

class FuncionarioState extends Equatable {
  final FuncionarioStatus status;
  final List<Funcionario> funcionarios;
  final List<Funcionario> funcionariosEquipe;
  final String? errorMessage;

  const FuncionarioState(
    this.status,
    this.funcionarios,
    this.funcionariosEquipe,
    this.errorMessage,
  );

  FuncionarioState.initial()
      : status = FuncionarioStatus.initial,
        funcionarios = [],
        funcionariosEquipe = [],
        errorMessage = null;

  @override
  List<Object?> get props => [
        status,
        funcionarios,
        funcionariosEquipe,
        errorMessage,
      ];

  FuncionarioState copyWith({
    FuncionarioStatus? status,
    List<Funcionario>? funcionarios,
    List<Funcionario>? funcionariosEquipe,
    String? errorMessage,
  }) {
    return FuncionarioState(
      status ?? this.status,
      funcionarios ?? this.funcionarios,
      funcionariosEquipe ?? this.funcionariosEquipe,
      errorMessage ?? this.errorMessage,
    );
  }
}
