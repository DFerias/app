import 'package:app/features/pages/equipe/equipe_controller/equipe_controller.dart';
import 'package:app/features/pages/equipe/equipe_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EquipeRoutes {
  EquipeRoutes._();

  static Widget get page => BlocProvider(
        create: (context) => context.read<EquipeController>(),
        child: const EquipePage(),
      );
}
