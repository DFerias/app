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
  String? cidade;
  Map<String, dynamic>? equipe;
  String? uf;
  String? modalidade;
  List<Modalidade>? listaModalidades;
  DateTime? dataAdmissao;
  bool? passVisible;
  bool? validarData;
  bool? validarCidade;
  bool? validarEquipe;
  bool? validarUf;
  bool? validarModalidade;

  CadastrarFuncionarioState({
    this.status,
    this.errorMessage,
    this.listaUfs,
    this.funcionario,
    this.cidade,
    this.equipe,
    this.uf,
    this.modalidade,
    this.listaModalidades,
    this.dataAdmissao,
    this.passVisible,
    this.validarData,
    this.validarCidade,
    this.validarEquipe,
    this.validarUf,
    this.validarModalidade,
  });

  CadastrarFuncionarioState.initial()
      : status = CadastrarFuncionarioStatus.initial,
        errorMessage = null,
        listaUfs = null,
        funcionario = null,
        cidade = null,
        equipe = null,
        uf = null,
        modalidade = null,
        listaModalidades = [],
        dataAdmissao = null,
        passVisible = false,
        validarData = true,
        validarCidade = true,
        validarEquipe = true,
        validarUf = true,
        validarModalidade = true;

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        listaUfs,
        funcionario,
        cidade,
        equipe,
        uf,
        modalidade,
        listaModalidades,
        dataAdmissao,
        passVisible,
        validarData,
        validarCidade,
        validarEquipe,
        validarUf,
        validarModalidade,
      ];

  CadastrarFuncionarioState copyWith({
    CadastrarFuncionarioStatus? status,
    String? errorMessage,
    Map<String, String>? listaUfs,
    Funcionario? funcionario,
    String? cidade,
    Map<String, dynamic>? equipe,
    String? uf,
    String? modalidade,
    List<Modalidade>? listaModalidades,
    DateTime? dataAdmissao,
    bool? passVisible,
    bool? validarData,
    bool? validarCidade,
    bool? validarEquipe,
    bool? validarUf,
    bool? validarModalidade,
  }) {
    return CadastrarFuncionarioState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      listaUfs: listaUfs ?? this.listaUfs,
      funcionario: funcionario ?? this.funcionario,
      cidade: cidade ?? this.cidade,
      equipe: equipe ?? this.equipe,
      uf: uf ?? this.uf,
      modalidade: modalidade ?? this.modalidade,
      listaModalidades: listaModalidades ?? this.listaModalidades,
      dataAdmissao: dataAdmissao ?? this.dataAdmissao,
      passVisible: passVisible ?? this.passVisible,
      validarData: validarData ?? this.validarData,
      validarCidade: validarCidade ?? this.validarCidade,
      validarEquipe: validarEquipe ?? this.validarEquipe,
      validarUf: validarUf ?? this.validarUf,
      validarModalidade: validarModalidade ?? this.validarModalidade,
    );
  }
}
