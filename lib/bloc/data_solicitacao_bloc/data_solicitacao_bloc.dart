import 'package:bloc/bloc.dart';

part 'data_solicitacao_event.dart';
part 'data_solicitacao_state.dart';

class DataSolicitacaoBloc extends Bloc<DataSolicitacaoEvent, DataSolicitacaoState> {
  static final DataSolicitacaoBloc instance = DataSolicitacaoBloc();

  DataSolicitacaoBloc() : super(DataSolicitacaoInitial()) {
    on<CleanEvent>(
      (event, emit) => emit(DataSolicitacaoInitial()),
    );

    on<SelectDataInicialEvent>(
      (event, emit) => emit((state as DataSolicitacaoInitial).copyWith(dataInicial: event.dataInicio)),
    );

    on<SelectDataFinalEvent>(
      (event, emit) => emit((state as DataSolicitacaoInitial).copyWith(dataFinal: event.dataFinal)),
    );
  }
}
