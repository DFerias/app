part of 'cadastrar_funcionario_bloc.dart';

enum CadastrarFuncionarioStatus {
  initial,
  loading,
  sucess,
  error,
}

class CadastrarFuncionarioState extends Equatable {
  final CadastrarFuncionarioStatus status;
  final String? errorMessage;

  final Map<String, String>? listaUfs;
  final FuncionarioModel? funcionario;
  final String? uf;
  final String? modalidade;
  final List<Modalidade> listaModalidades;
  final DateTime? dataAdmissao;
  final bool? passVisible;
  final bool? validarData;
  final bool? validarUf;
  final bool? validarModalidade;

  const CadastrarFuncionarioState(
    this.status,
    this.errorMessage,
    this.listaUfs,
    this.funcionario,
    this.uf,
    this.modalidade,
    this.listaModalidades,
    this.dataAdmissao,
    this.passVisible,
    this.validarData,
    this.validarUf,
    this.validarModalidade,
  );

  CadastrarFuncionarioState.initial()
      : status = CadastrarFuncionarioStatus.initial,
        errorMessage = null,
        listaUfs = null,
        funcionario = null,
        uf = null,
        modalidade = null,
        listaModalidades = [],
        dataAdmissao = null,
        passVisible = false,
        validarData = false,
        validarUf = null,
        validarModalidade = null;

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        listaUfs,
        funcionario,
        uf,
        modalidade,
        listaModalidades,
        dataAdmissao,
        passVisible,
        validarData,
        validarUf,
        validarModalidade,
      ];

  CadastrarFuncionarioState copyWith({
    CadastrarFuncionarioStatus? status,
    String? errorMessage,
    Map<String, String>? listaUfs,
    FuncionarioModel? funcionario,
    String? uf,
    String? modalidade,
    List<Modalidade>? listaModalidades,
    DateTime? dataAdmissao,
    bool? passVisible,
    bool? validarData,
    bool? validarUf,
    bool? validarModalidade,
  }) {
    return CadastrarFuncionarioState(
      status ?? this.status,
      errorMessage ?? this.errorMessage,
      listaUfs ?? this.listaUfs,
      funcionario ?? this.funcionario,
      uf ?? this.uf,
      modalidade ?? this.modalidade,
      listaModalidades ?? this.listaModalidades,
      dataAdmissao ?? this.dataAdmissao,
      passVisible ?? this.passVisible,
      validarData ?? this.validarData,
      validarUf ?? this.validarUf,
      validarModalidade ?? this.validarModalidade,
    );
  }
}

/* class CadastrarFuncionarioInitial extends CadastrarFuncionarioState {
  CadastrarFuncionarioInitial({
    required CadastrarFuncionarioStatus status,
    Map<String, String>? listaUfs,
    FuncionarioModel? funcionario,
    String? uf,
    String? modalidade,
    DateTime? dataAdmissao,
    bool? passVisible = false,
    bool? validarData,
    bool? validarUf,
    bool? validarModalidade,
  }) : super(
          status: CadastrarFuncionarioStatus.initial,
          listaUfs: utilListaUFs,
          funcionario: funcionario,
          uf: uf,
          modalidade: modalidade,
          dataAdmissao: dataAdmissao,
          passVisible: passVisible,
          validarData: validarData,
          validarUf: validarUf,
          validarModalidade: validarModalidade,
        );

  CadastrarFuncionarioInitial copyWith({
    required CadastrarFuncionarioInitial status,
    Map<String, String>? listaUfs,
    FuncionarioModel? funcionario,
    String? uf,
    String? modalidade,
    DateTime? dataAdmissao,
    bool? passVisible = false,
    bool? validarData,
    bool? validarUf,
    bool? validarModalidade,
  }) {
    return CadastrarFuncionarioInitial(
      status: null,
      listaUfs: listaUfs,
      funcionario: funcionario,
      uf: uf ?? this.uf,
      modalidade: modalidade ?? this.modalidade,
      dataAdmissao: dataAdmissao ?? this.dataAdmissao,
      passVisible: passVisible ?? (this.passVisible ?? false),
      validarData: validarData ?? (this.validarData ?? false),
      validarUf: validarUf ?? (this.validarUf ?? false),
      validarModalidade: validarModalidade ?? (this.validarModalidade ?? false),
    );
  }
} */

// class LoadingState extends CadastrarFuncionarioInitial {}

// class SuccessState extends CadastrarFuncionarioInitial {}

/* class ErrorState extends CadastrarFuncionarioInitial {
  String messageErro;

  ErrorState({
    required this.messageErro,
  });
} */
