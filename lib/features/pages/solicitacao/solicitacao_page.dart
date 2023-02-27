import 'package:app/core/ui/base_state/base_state.dart';
import 'package:app/features/pages/shared/dferias_appbar.dart';
import 'package:app/features/pages/solicitacao/widgets/list_view_sol_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'solicitacao_controller/solicitacao_equipe_controller.dart';

class SolicitacaoPage extends StatefulWidget {
  const SolicitacaoPage({super.key});

  @override
  State<SolicitacaoPage> createState() => _SolicitacaoPageState();
}

class _SolicitacaoPageState extends BaseState<SolicitacaoPage, SolicitacaoEquipeController> {
  @override
  void onReady() {
    controller.loadFeriasEquipe();
    super.onReady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DFeriasAppbar(title: 'Solicitacões Equipe'),
      body: BlocBuilder<SolicitacaoEquipeController, SolicitacaoEquipeState>(
        buildWhen: (previous, current) {
          if (current.status == SolicitacaoEquipeStatus.loaded) {
            return true;
          }

          return false;
        },
        builder: (context, state) {
          return ListViewSolWidget(
            listaSolFerias: controller.state.solFerias ?? [],
          );
        },
      ),
    );
  }
}
