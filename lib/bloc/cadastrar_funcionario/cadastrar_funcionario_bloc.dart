import 'package:app/index.dart';
import 'package:bloc/bloc.dart';

part 'cadastrar_funcionario_event.dart';
part 'cadastrar_funcionario_state.dart';

class CadastrarFuncionarioBloc extends Bloc<CadastrarFuncionarioEvent, CadastrarFuncionarioState> {
  static final CadastrarFuncionarioBloc instance = CadastrarFuncionarioBloc();

  CadastrarFuncionarioBloc() : super(CadastrarFuncionarioInitial()) {
    on<FinalizarCadastroEvent>(
      (event, emit) async {
        if (event.funcionario!.formKey!.currentState!.validate() && state.uf != null && state.modalidade != null /* && state.validarData != null */) {
          Dialogs.showLoadingDialog();
          await CadastroFuncionarioRepository().cadastrarFuncionarioRepo(event.funcionario!).then((_) {
            Dialogs.close();
          });
        }

        emit((state as CadastrarFuncionarioInitial).copyWith(listaUfs: state.listaUfs));
      },
    );

    on<ListaUfsEvent>(
      (event, emit) => emit((state as CadastrarFuncionarioInitial).copyWith(listaUfs: state.listaUfs)),
    );

    on<SelectUfEvent>(
      (event, emit) => emit((state as CadastrarFuncionarioInitial).copyWith(uf: event.uf)),
    );

    on<SelectModalidadeEvent>(
      (event, emit) => emit((state as CadastrarFuncionarioInitial).copyWith(modalidade: event.modalidade)),
    );

    on<SelectDataAdmissaoEvent>(
      (event, emit) => emit((state as CadastrarFuncionarioInitial).copyWith(dataAdmissao: event.dataAdmissao)),
    );

    on<PassVisibleEvent>(
      (event, emit) => emit((state as CadastrarFuncionarioInitial).copyWith(passVisible: !(state.passVisible ?? true))),
    );

    on<ValidarDataEvent>(
      (event, emit) {
        if (state.dataAdmissao != null) {
          emit((state as CadastrarFuncionarioInitial).copyWith(validarData: state.validarData = true));
        } else {
          emit((state as CadastrarFuncionarioInitial).copyWith(validarData: state.validarData = false));
        }
      },
    );

    on<ValidarUfEvent>(
      (event, emit) {
        if (state.uf != null) {
          emit((state as CadastrarFuncionarioInitial).copyWith(validarUf: state.validarUf = true));
        } else {
          emit((state as CadastrarFuncionarioInitial).copyWith(validarUf: state.validarUf = false));
        }
      },
    );

    on<ValidarModalidadeEvent>(
      (event, emit) {
        if (state.modalidade != null) {
          emit((state as CadastrarFuncionarioInitial).copyWith(validarModalidade: state.validarModalidade = true));
        } else {
          emit((state as CadastrarFuncionarioInitial).copyWith(validarModalidade: state.validarModalidade = false));
        }
      },
    );
  }
}
