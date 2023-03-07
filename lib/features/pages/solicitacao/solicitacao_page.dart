import 'package:app/core/ui/base_state/base_state.dart';
import 'package:app/features/pages/shared/dferias_appbar.dart';
import 'package:app/features/pages/solicitacao/widgets/list_view_sol_widget.dart';
import 'package:app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'solicitacao_controller/solicitacao_equipe_controller.dart';

class SolicitacaoPage extends StatefulWidget {
  const SolicitacaoPage({super.key});

  @override
  State<SolicitacaoPage> createState() => _SolicitacaoPageState();
}

class _SolicitacaoPageState extends BaseState<SolicitacaoPage, SolicitacaoEquipeController> {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.loadFeriasEquipe();
      await controller.loadFeriasValidadas();
    });
  }

  void _handleTabSelection() {
    setState(() {});
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
          if (AuthService.instance.authRh == true) {
            return Column(
              children: [
                TabBar(
                  controller: _tabController,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
                  tabs: const [
                    Tab(text: 'Equipe'),
                    Tab(text: 'Pendentes Aprovação'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListViewSolWidget(listaSolFerias: controller.state.solFerias ?? []),
                      ListViewSolWidget(listaSolFerias: controller.state.solFeriasTodos ?? []),
                    ],
                  ),
                )
              ],
            );
          } else {
            return ListViewSolWidget(
              listaSolFerias: controller.state.solFerias ?? [],
            );
          }
        },
      ),
    );
  }
}
