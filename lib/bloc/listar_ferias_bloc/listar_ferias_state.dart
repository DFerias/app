part of 'listar_ferias_bloc.dart';

abstract class ListarFeriasState {
  ListarFeriasState();
}

class ListarFeriasInitialState extends ListarFeriasState {
  ListarFeriasInitialState() : super();
}

class SuccessListState extends ListarFeriasState {
  SuccessListState() : super();
}

class LoadingListState extends ListarFeriasState {
  LoadingListState();
}

class RefreshListState extends ListarFeriasState {}

class ErrorListState extends ListarFeriasState {}
