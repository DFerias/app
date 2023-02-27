import 'package:app/features/pages/funcionario/cubit/lista_funcionario_cubit/funcionario_controller.dart';
import 'package:app/features/pages/funcionario/funcionario_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FuncionarioRoutes {
  FuncionarioRoutes._();

  static Widget get page => BlocProvider(
        create: (context) => FuncionarioController(),
        child: const FuncionarioPage(),
      );
}
