import 'package:app/core/ui/base_state/base_state.dart';
import 'package:app/features/pages/historico/cubit/historico_controller.dart';
import 'package:app/features/pages/historico/widgets/list_view_widget.dart';
import 'package:app/features/pages/shared/dferias_appbar.dart';
import 'package:app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoricoPage extends StatefulWidget {
  const HistoricoPage({super.key});

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends BaseState<HistoricoPage, HistoricoController> {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadAllFerias(AuthService.instance.usuario!.id!);
    });
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DFeriasAppbar(
        title: 'Histórico de Solicitações',
      ),
      body: BlocBuilder<HistoricoController, HistoricoState>(
        buildWhen: (previous, current) {
          if (current.status == HistoricoStatus.loaded) {
            return true;
          }

          return false;
        },
        builder: (context, state) {
          return Column(
            children: [
              TabBar(
                controller: _tabController,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
                tabs: const [
                  Tab(text: 'Todas'),
                  Tab(text: 'Recusadas'),
                  Tab(text: 'Aprovadas'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    ListViewWidget(
                      listaFerias: controller.state.listaTodos!,
                      tab: _tabController.index,
                    ),
                    ListViewWidget(
                      listaFerias: controller.state.listaRejeitados!,
                      tab: _tabController.index,
                    ),
                    ListViewWidget(
                      listaFerias: controller.state.listaAprovados!,
                      tab: _tabController.index,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          ModalSheetSolicitacao.showModalSheetSolicitacao('/home/historico').then((value) async {
            if (value == true) {
              await controller.loadAllFerias(AuthService.instance.usuario!.id!);
            }
          });
        },
        child: const Icon(
          Icons.post_add_outlined,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );
  }
}
