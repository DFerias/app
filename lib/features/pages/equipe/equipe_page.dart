import 'package:app/core/ui/base_state/base_state.dart';
import 'package:app/features/pages/equipe/equipe_controller/equipe_controller.dart';
import 'package:app/features/pages/equipe/widgets/list_view_equipe.dart';
import 'package:app/features/pages/shared/dferias_appbar.dart';
import 'package:app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EquipePage extends StatefulWidget {
  const EquipePage({super.key});

  @override
  State<EquipePage> createState() => _EquipePageState();
}

class _EquipePageState extends BaseState<EquipePage, EquipeController> {
  @override
  void onReady() {
    super.onReady();

    controller.getEquipes();
  }

  Future<void> onRefresh() async {
    controller.getEquipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DFeriasAppbar(
        title: 'Equipes',
      ),
      body: BlocBuilder<EquipeController, EquipeState>(
        builder: (context, state) {
          if (state.status == EquipeStatus.loading) {
            return const Loading(
              texto: 'Aguarde, carregando dados...',
            );
          } else if (state.status == EquipeStatus.initial || controller.state.equipes.isEmpty) {
            return NotificationListener<ScrollNotification>(
              child: RefreshIndicator(
                onRefresh: onRefresh,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/data_empty.gif',
                            scale: 2.0,
                          ),
                          Text(
                            'Nenhuma Solicitação Encontrada',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state.status == EquipeStatus.error) {
            Dialogs.showSnackBar(
              context,
              state.errorMessage ?? '',
              cor: Colors.red,
            );
          }

          return ListViewEquipe(lista: controller.state.equipes);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          ModalSheetCadastroEquipe.showModalSheetCadastroEquipe(controller).then((value) {
            if (value == true) {
              Dialogs.showAlertDialog('Equipe cadastrado com sucesso!', 'Sucesso!').then((value) => onRefresh());
            }
          });
        },
        child: const Icon(
          Icons.group_add_outlined,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );
  }
}
