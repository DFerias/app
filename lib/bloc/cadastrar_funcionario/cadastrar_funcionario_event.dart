part of 'cadastrar_funcionario_bloc.dart';

abstract class CadastrarFuncionarioEvent {}

class FinalizarCadastroEvent extends CadastrarFuncionarioEvent {
  FuncionarioModel? funcionario;
  FinalizarCadastroEvent({
    this.funcionario,
  });
}

class ListaUfsEvent extends CadastrarFuncionarioEvent {
  Map<String, String>? listaUfs;

  ListaUfsEvent({
    this.listaUfs,
  });
}

class SelectUfEvent extends CadastrarFuncionarioEvent {
  String? uf;

  SelectUfEvent({
    this.uf,
  });
}

class SelectModalidadeEvent extends CadastrarFuncionarioEvent {
  String? modalidade;

  SelectModalidadeEvent({
    this.modalidade,
  });
}

class SelectDataAdmissaoEvent extends CadastrarFuncionarioEvent {
  DateTime? dataAdmissao;

  SelectDataAdmissaoEvent({
    this.dataAdmissao,
  });
}

class PassVisibleEvent extends CadastrarFuncionarioEvent {
  PassVisibleEvent();
}

class ValidarDataEvent extends CadastrarFuncionarioEvent {
  ValidarDataEvent();
}

class ValidarUfEvent extends CadastrarFuncionarioEvent {
  ValidarUfEvent();
}

class ValidarModalidadeEvent extends CadastrarFuncionarioEvent {
  ValidarModalidadeEvent();
}
