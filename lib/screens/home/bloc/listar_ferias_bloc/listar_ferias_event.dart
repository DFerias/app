part of 'listar_ferias_bloc.dart';

abstract class ListarFeriasEvent {}

class LoadListEvent extends ListarFeriasEvent {
  LoadListEvent();
}

class RefreshListEvent extends ListarFeriasEvent {
  RefreshListEvent();
}
