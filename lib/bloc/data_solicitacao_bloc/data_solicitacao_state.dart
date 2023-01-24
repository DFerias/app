part of 'data_solicitacao_bloc.dart';

abstract class DataSolicitacaoState {
  DateTime? dataInicial;
  DateTime? dataFinal;

  DataSolicitacaoState({
    this.dataInicial,
    this.dataFinal,
  });
}

class DataSolicitacaoInitial extends DataSolicitacaoState {
  DataSolicitacaoInitial({
    DateTime? dataInicial,
    DateTime? dataFinal,
  }) : super(
          dataInicial: dataInicial,
          dataFinal: dataFinal,
        );

  DataSolicitacaoInitial copyWith({
    DateTime? dataInicial,
    DateTime? dataFinal,
  }) {
    return DataSolicitacaoInitial(
      dataInicial: dataInicial ?? this.dataInicial,
      dataFinal: dataFinal ?? this.dataFinal,
    );
  }
}
