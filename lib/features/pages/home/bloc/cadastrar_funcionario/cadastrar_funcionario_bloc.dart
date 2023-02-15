import 'package:app/core/injections/injection.dart' as di;
import 'package:app/index.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'cadastrar_funcionario_event.dart';
part 'cadastrar_funcionario_state.dart';

class CadastrarFuncionarioController extends Cubit<CadastrarFuncionarioState> {
  CadastrarFuncionarioController() : super(CadastrarFuncionarioState.initial());

  void clear() {
    // state.uf = null;
  }

  Future<void> addFuncionario(Funcionario funcionario, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate() && state.uf != null && state.modalidade != null /* && state.validarData != null */) {
      emit(state.copyWith(status: CadastrarFuncionarioStatus.loading));
      final addFuncionario = di.getIt<FuncionarioUsecase>();

      try {
        final result = await addFuncionario.call(funcionario);

        result.fold(
          (l) => emit(state.copyWith(status: CadastrarFuncionarioStatus.error, errorMessage: l.message)),
          (r) => emit(state.copyWith(status: CadastrarFuncionarioStatus.sucess)),
        );
      } catch (e) {
        emit(state.copyWith(status: CadastrarFuncionarioStatus.error, errorMessage: e.toString()));
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
      emit(state.copyWith(validarData: state.validarData = true));
    } else {
      emit(state.copyWith(validarData: state.validarData = false));
    }
  }

  //  {
  //   on<FinalizarCadastroEvent>(
  //     (event, emit) async {
  //       if (event.funcionario!.formKey!.currentState!.validate() && state.uf != null && state.modalidade != null /* && state.validarData != null */) {
  //         emit(state.copyWith(status: CadastrarFuncionarioStatus.loading));
  //         var result = await CadastroFuncionarioRepository().cadastrarFuncionarioRepo(event.funcionario!);

  //         if (result is FuncionarioModel) {
  //           emit(state.copyWith(status: CadastrarFuncionarioStatus.sucess));
  //         } else {
  //           emit(state.copyWith(status: CadastrarFuncionarioStatus.error, errorMessage: result));
  //         }
  //       }
  //     },
  //   );

  // on<ListaUfsEvent>(
  //   (event, emit) => emit((state).copyWith(listaUfs: state.listaUfs, status: CadastrarFuncionarioStatus.initial)),
  // );

  // on<SelectUfEvent>(
  //   (event, emit) => emit((state).copyWith(uf: event.uf, status: CadastrarFuncionarioStatus.initial)),
  // );

  // on<SelectModalidadeEvent>(
  //   (event, emit) => emit((state).copyWith(modalidade: event.modalidade, status: CadastrarFuncionarioStatus.initial)),
  // );

  // on<SelectDataAdmissaoEvent>(
  //   (event, emit) => emit((state).copyWith(dataAdmissao: event.dataAdmissao, status: CadastrarFuncionarioStatus.initial)),
  // );

//     on<PassVisibleEvent>(
//       (event, emit) => emit((state).copyWith(passVisible: !(state.passVisible ?? true), status: CadastrarFuncionarioStatus.initial)),
//     );

//     on<ValidarDataEvent>(
//       (event, emit) {
//         if (state.dataAdmissao != null) {
//           emit((state).copyWith(validarData: state.validarData = true, status: CadastrarFuncionarioStatus.initial));
//         } else {
//           emit((state).copyWith(validarData: state.validarData = false, status: CadastrarFuncionarioStatus.initial));
//         }
//       },
//     );

//     on<ValidarUfEvent>(
//       (event, emit) {
//         if (state.uf != null) {
//           emit((state).copyWith(validarUf: state.validarUf = true, status: CadastrarFuncionarioStatus.initial));
//         } else {
//           emit((state).copyWith(validarUf: state.validarUf = false, status: CadastrarFuncionarioStatus.initial));
//         }
//       },
//     );

//     on<ValidarModalidadeEvent>(
//       (event, emit) {
//         if (state.modalidade != null) {
//           emit((state).copyWith(validarModalidade: state.validarModalidade = true, status: CadastrarFuncionarioStatus.initial));
//         } else {
//           emit((state).copyWith(validarModalidade: state.validarModalidade = false, status: CadastrarFuncionarioStatus.initial));
//         }
//       },
//     );
//   }
}
