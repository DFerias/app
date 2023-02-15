part of 'cadastrar_funcionario_bloc.dart';

enum CadastrarFuncionarioStatus {
  initial,
  loading,
  update,
  loaded,
  sucess,
  error,
}

// ignore: must_be_immutable
class CadastrarFuncionarioState extends Equatable {
  CadastrarFuncionarioStatus? status;
  String? errorMessage;
  Map<String, String>? listaUfs;
  Funcionario? funcionario;
  String? uf;
  String? modalidade;
  List<Modalidade>? listaModalidades;
  DateTime? dataAdmissao;
  bool? passVisible;
  bool? validarData;
  bool? validarUf;
  bool? validarModalidade;

  CadastrarFuncionarioState({
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
  });

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
        validarData = null,
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
    Funcionario? funcionario,
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
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      listaUfs: listaUfs ?? this.listaUfs,
      funcionario: funcionario ?? this.funcionario,
      uf: uf ?? this.uf,
      modalidade: modalidade ?? this.modalidade,
      listaModalidades: listaModalidades ?? this.listaModalidades,
      dataAdmissao: dataAdmissao ?? this.dataAdmissao,
      passVisible: passVisible ?? this.passVisible,
      validarData: validarData ?? this.validarData,
      validarUf: validarUf ?? this.validarUf,
      validarModalidade: validarModalidade ?? this.validarModalidade,
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
