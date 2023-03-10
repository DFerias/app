import 'package:app/features/pages/equipe/funcionario_equipe_page.dart';
import 'package:app/features/pages/funcionario/cubit/lista_funcionario_cubit/funcionario_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FuncionarioEquipeRoutes {
  FuncionarioEquipeRoutes._();

  static Widget get page => Provider(
        create: (context) => FuncionarioController(),
        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

          return FuncionarioEquipePage(nomeEquipe: args['nomeEquipe'], idEquipe: args['idEquipe']);
        },
      );
}
