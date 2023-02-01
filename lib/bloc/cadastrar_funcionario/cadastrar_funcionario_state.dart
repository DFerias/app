part of 'cadastrar_funcionario_bloc.dart';

abstract class CadastrarFuncionarioState {
  Map<String, String>? listaUfs;
  FuncionarioModel? funcionario;
  String? uf;
  String? modalidade;
  DateTime? dataAdmissao;
  bool? passVisible = false;
  bool? validarData = false;
  bool? validarUf;
  bool? validarModalidade;

  CadastrarFuncionarioState({
    this.listaUfs,
    this.funcionario,
    this.uf,
    this.modalidade,
    this.dataAdmissao,
    this.passVisible,
    this.validarData,
    this.validarUf,
    this.validarModalidade,
  });
}

class CadastrarFuncionarioInitial extends CadastrarFuncionarioState {
  CadastrarFuncionarioInitial({
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
}
