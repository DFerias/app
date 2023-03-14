part of 'funcionario_controller.dart';

enum FuncionarioStatus {
  initial,
  loading,
  loaded,
  error;
}

class FuncionarioState extends Equatable {
  final FuncionarioStatus status;
  final Funcionario? funcionario;
  final List<Funcionario> funcionarios;
  final List<Funcionario> funcionariosEquipe;
  final String? errorMessage;

  const FuncionarioState(
    this.status,
    this.funcionario,
    this.funcionarios,
    this.funcionariosEquipe,
    this.errorMessage,
  );

  FuncionarioState.initial()
      : status = FuncionarioStatus.initial,
        funcionario = null,
        funcionarios = [],
        funcionariosEquipe = [],
        errorMessage = null;

  @override
  List<Object?> get props => [
        status,
        funcionario,
        funcionarios,
        funcionariosEquipe,
        errorMessage,
      ];

  FuncionarioState copyWith({
    FuncionarioStatus? status,
    Funcionario? funcionario,
    List<Funcionario>? funcionarios,
    List<Funcionario>? funcionariosEquipe,
    String? errorMessage,
  }) {
    return FuncionarioState(
      status ?? this.status,
      funcionario ?? this.funcionario,
      funcionarios ?? this.funcionarios,
      funcionariosEquipe ?? this.funcionariosEquipe,
      errorMessage ?? this.errorMessage,
    );
  }
}
