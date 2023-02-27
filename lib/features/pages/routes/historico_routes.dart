import 'package:app/features/pages/historico/cubit/historico_controller.dart';
import 'package:app/features/pages/historico/historico_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoricoRoutes {
  HistoricoRoutes._();

  static Widget get page => BlocProvider(
        create: (context) => HistoricoController(),
        child: const HistoricoPage(),
      );
}
