part of 'data_solicitacao_bloc.dart';

abstract class DataSolicitacaoEvent {}

class CleanEvent extends DataSolicitacaoEvent {
  CleanEvent();
}

class SelectDataInicialEvent extends DataSolicitacaoEvent {
  DateTime? dataInicio;

  SelectDataInicialEvent({
    this.dataInicio,
  });
}

class SelectDataFinalEvent extends DataSolicitacaoEvent {
  DateTime? dataFinal;

  SelectDataFinalEvent({
    this.dataFinal,
  });
}
