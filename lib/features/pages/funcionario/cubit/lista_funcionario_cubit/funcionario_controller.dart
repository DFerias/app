import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'funcionario_state.dart';

class FuncionarioController extends Cubit<FuncionarioState> {
  FuncionarioController() : super(FuncionarioInitial());
}
