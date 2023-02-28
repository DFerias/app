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
  final String? errorMessage;

  const FuncionarioState(
    this.status,
    this.funcionarios,
    this.errorMessage,
  );

  FuncionarioState.initial()
      : status = FuncionarioStatus.initial,
        funcionarios = [],
        errorMessage = null;

  @override
  List<Object?> get props => [
        status,
        funcionarios,
        errorMessage,
      ];

  FuncionarioState copyWith({
    FuncionarioStatus? status,
    List<Funcionario>? funcionarios,
    String? errorMessage,
  }) {
    return FuncionarioState(
      status ?? this.status,
      funcionarios ?? this.funcionarios,
      errorMessage ?? this.errorMessage,
    );
  }
}
