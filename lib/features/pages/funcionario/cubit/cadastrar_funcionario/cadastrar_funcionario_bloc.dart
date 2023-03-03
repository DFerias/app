import 'dart:developer';

import 'package:app/core/errors/failure.dart';
import 'package:app/core/injections/injection.dart' as di;
import 'package:app/index.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'cadastrar_funcionario_event.dart';
part 'cadastrar_funcionario_state.dart';

class CadastrarFuncionarioController extends Cubit<CadastrarFuncionarioState> {
  CadastrarFuncionarioController() : super(CadastrarFuncionarioState.initial());

  Future<void> addFuncionario(Funcionario funcionario, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate() && state.uf != null && state.modalidade != null && state.dataAdmissao != null) {
      emit(state.copyWith(status: CadastrarFuncionarioStatus.loading));
      final addFuncionario = di.getIt<AddFuncionarioUsecase>();

      try {
        final result = await addFuncionario.call(funcionario);

        result.fold(
          (l) => emit(state.copyWith(status: CadastrarFuncionarioStatus.error, errorMessage: l.message)),
          (r) => emit(state.copyWith(status: CadastrarFuncionarioStatus.sucess)),
        );
      } on Failure catch (e) {
        emit(state.copyWith(status: CadastrarFuncionarioStatus.error, errorMessage: e.message));
      }
    }
  }

  Future<void> listarModalidades() async {
    emit(state.copyWith(status: CadastrarFuncionarioStatus.update));

    final getModalidades = di.getIt<ModalidadeUsecase>();

    try {
      await getModalidades.call().then((modalidades) {
        modalidades.fold(
          (l) => emit(state.copyWith(status: CadastrarFuncionarioStatus.error, errorMessage: l.message)),
          (r) => emit(state.copyWith(status: CadastrarFuncionarioStatus.loaded, listaModalidades: r)),
        );
      });
    } catch (e) {
      emit(state.copyWith(status: CadastrarFuncionarioStatus.error, errorMessage: e.toString()));
    }
  }

  void selectCidade(String cidadeSelected) {
    emit(state.copyWith(cidade: cidadeSelected));

    inspect(state.cidade);
  }

  void selectEquipe(Map<String, dynamic> equipeSelected) {
    emit(state.copyWith(equipe: equipeSelected));

    inspect(state.equipe);
  }

  void selectUf(String ufSelected) {
    emit(state.copyWith(uf: ufSelected));
  }

  void selectModalidade(String modalidadeSelected) {
    emit(state.copyWith(modalidade: modalidadeSelected));
  }

  void selectDataAdmissao(DateTime dataAdmissaoSelected) {
    emit(state.copyWith(dataAdmissao: dataAdmissaoSelected));
  }

  void seePassword() {
    emit(state.copyWith(passVisible: !(state.passVisible ?? true)));
  }

  void validateData() {
    if (state.dataAdmissao != null) {
      emit(state.copyWith(validarData: state.validarData = true, status: CadastrarFuncionarioStatus.initial));
    } else {
      emit(state.copyWith(validarData: state.validarData = false, status: CadastrarFuncionarioStatus.initial));
    }
  }

  void validateCidade() {
    if (state.cidade != null) {
      emit(state.copyWith(validarCidade: state.validarCidade = true));
    } else {
      emit(state.copyWith(validarCidade: state.validarCidade = false));
    }
  }

  void validateEquipe() {
    if (state.equipe != null) {
      emit(state.copyWith(validarEquipe: state.validarEquipe = true));
    } else {
      emit(state.copyWith(validarEquipe: state.validarEquipe = false));
    }
  }

  void validateUf() {
    if (state.uf != null) {
      emit(state.copyWith(validarUf: state.validarUf = true));
    } else {
      emit(state.copyWith(validarUf: state.validarUf = false));
    }
  }

  void validateModalidade() {
    if (state.modalidade != null) {
      emit(state.copyWith(validarModalidade: state.validarModalidade = true));
    } else {
      emit(state.copyWith(validarModalidade: state.validarModalidade = false));
    }
  }
}
