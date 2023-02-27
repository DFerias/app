import 'package:app/features/pages/solicitacao/solicitacao_controller/solicitacao_equipe_controller.dart';
import 'package:app/features/pages/solicitacao/solicitacao_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SolicitacaoRoutes {
  SolicitacaoRoutes._();

  static Widget get page => BlocProvider(
        create: (context) => SolicitacaoEquipeController(),
        child: const SolicitacaoPage(),
      );
}
