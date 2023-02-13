import 'package:app/features/domain/entities/funcionario.dart';
import 'package:app/features/domain/entities/modalidade.dart';
import 'package:app/features/domain/usecases/funcionario_usecase.dart';
import 'package:app/features/domain/usecases/modalidade_usecase.dart';
import 'package:app/index.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cadastrar_funcionario_event.dart';
part 'cadastrar_funcionario_state.dart';

class CadastrarFuncionarioController extends Cubit<CadastrarFuncionarioState> {
  final FuncionarioUsecase _funcionarioUsecase;
  final ModalidadeUsecase _modalidadeUsecase;

  CadastrarFuncionarioController(
    this._funcionarioUsecase,
    this._modalidadeUsecase,
  ) : super(CadastrarFuncionarioState.initial());

  Future<void> addFuncionario(Funcionario funcionario) async {
    emit(state);
  }

  Future<void> listarModalidades() async {
    emit(state.copyWith(status: CadastrarFuncionarioStatus.loading));

    try {
      await _modalidadeUsecase.call().then((modalidades) {
        modalidades.fold(
          (l) => emit(state.copyWith(status: CadastrarFuncionarioStatus.error, errorMessage: l.message)),
          (r) => emit(state.copyWith(listaModalidades: r)),
        );
      });
    } catch (e) {
      emit(state.copyWith(status: CadastrarFuncionarioStatus.error, errorMessage: e.toString()));
    }
  }

  /* {
    on<FinalizarCadastroEvent>(
      (event, emit) async {
        if (event.funcionario!.formKey!.currentState!.validate() && state.uf != null && state.modalidade != null /* && state.validarData != null */) {
          emit(state.copyWith(status: CadastrarFuncionarioStatus.loading));
          var result = await CadastroFuncionarioRepository().cadastrarFuncionarioRepo(event.funcionario!);

          if (result is FuncionarioModel) {
            emit(state.copyWith(status: CadastrarFuncionarioStatus.sucess));
          } else {
            emit(state.copyWith(status: CadastrarFuncionarioStatus.error, errorMessage: result));
          }
        }
      },
    );

    on<ListaUfsEvent>(
      (event, emit) => emit((state).copyWith(listaUfs: state.listaUfs, status: CadastrarFuncionarioStatus.initial)),
    );

    on<SelectUfEvent>(
      (event, emit) => emit((state).copyWith(uf: event.uf, status: CadastrarFuncionarioStatus.initial)),
    );

    on<SelectModalidadeEvent>(
      (event, emit) => emit((state).copyWith(modalidade: event.modalidade, status: CadastrarFuncionarioStatus.initial)),
    );

    on<SelectDataAdmissaoEvent>(
      (event, emit) => emit((state).copyWith(dataAdmissao: event.dataAdmissao, status: CadastrarFuncionarioStatus.initial)),
    );

    on<PassVisibleEvent>(
      (event, emit) => emit((state).copyWith(passVisible: !(state.passVisible ?? true), status: CadastrarFuncionarioStatus.initial)),
    );

    on<ValidarDataEvent>(
      (event, emit) {
        if (state.dataAdmissao != null) {
          emit((state).copyWith(validarData: state.validarData = true, status: CadastrarFuncionarioStatus.initial));
        } else {
          emit((state).copyWith(validarData: state.validarData = false, status: CadastrarFuncionarioStatus.initial));
        }
      },
    );

    on<ValidarUfEvent>(
      (event, emit) {
        if (state.uf != null) {
          emit((state).copyWith(validarUf: state.validarUf = true, status: CadastrarFuncionarioStatus.initial));
        } else {
          emit((state).copyWith(validarUf: state.validarUf = false, status: CadastrarFuncionarioStatus.initial));
        }
      },
    );

    on<ValidarModalidadeEvent>(
      (event, emit) {
        if (state.modalidade != null) {
          emit((state).copyWith(validarModalidade: state.validarModalidade = true, status: CadastrarFuncionarioStatus.initial));
        } else {
          emit((state).copyWith(validarModalidade: state.validarModalidade = false, status: CadastrarFuncionarioStatus.initial));
        }
      },
    );
  } */
}
