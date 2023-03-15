part of 'funcionario_controller.dart';

enum FuncionarioStatus {
  initial,
  loading,
  loaded,
  error;
}

// ignore: must_be_immutable
class FuncionarioState extends Equatable {
  FuncionarioStatus status;
  Funcionario? funcionario;
  List<Funcionario> funcionarios;
  List<Funcionario> funcionariosEquipe;
  String? errorMessage;
  Map<String, dynamic>? funcionarioSelected;
  bool? validarFuncionario;

  FuncionarioState(
    this.status,
    this.funcionario,
    this.funcionarios,
    this.funcionariosEquipe,
    this.errorMessage,
    this.funcionarioSelected,
    this.validarFuncionario,
  );

  FuncionarioState.initial()
      : status = FuncionarioStatus.initial,
        funcionario = null,
        funcionarios = [],
        funcionariosEquipe = [],
        errorMessage = null,
        funcionarioSelected = null,
        validarFuncionario = true;

  @override
  List<Object?> get props => [
        status,
        funcionario,
        funcionarios,
        funcionariosEquipe,
        errorMessage,
        funcionarioSelected,
        validarFuncionario,
      ];

  FuncionarioState copyWith({
    FuncionarioStatus? status,
    Funcionario? funcionario,
    List<Funcionario>? funcionarios,
    List<Funcionario>? funcionariosEquipe,
    String? errorMessage,
    Map<String, dynamic>? funcionarioSelected,
    bool? validarFuncionario,
  }) {
    return FuncionarioState(
      status ?? this.status,
      funcionario ?? this.funcionario,
      funcionarios ?? this.funcionarios,
      funcionariosEquipe ?? this.funcionariosEquipe,
      errorMessage ?? this.errorMessage,
      funcionarioSelected ?? this.funcionarioSelected,
      validarFuncionario ?? this.validarFuncionario,
    );
  }
}
