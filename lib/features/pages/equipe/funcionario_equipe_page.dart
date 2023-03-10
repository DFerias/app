import 'package:app/features/pages/shared/list_view_funcionario.dart';
import 'package:app/index.dart';
import 'package:flutter/material.dart';
import 'package:app/core/ui/base_state/base_state.dart';
import 'package:app/features/pages/funcionario/cubit/lista_funcionario_cubit/funcionario_controller.dart';
import 'package:app/features/pages/shared/dferias_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FuncionarioEquipePage extends StatefulWidget {
  final String nomeEquipe;
  final int idEquipe;

  const FuncionarioEquipePage({
    Key? key,
    required this.nomeEquipe,
    required this.idEquipe,
  }) : super(key: key);

  @override
  State<FuncionarioEquipePage> createState() => _FuncionarioEquipePageState();
}

class _FuncionarioEquipePageState extends BaseState<FuncionarioEquipePage, FuncionarioController> {
  @override
  void onReady() {
    super.onReady();

    controller.getFuncionariosEquipe(widget.idEquipe);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> onRefresh() async {
      controller.getFuncionariosEquipe(widget.idEquipe);
    }

    return Scaffold(
      appBar: DFeriasAppbar(
        title: widget.nomeEquipe,
      ),
      body: BlocBuilder<FuncionarioController, FuncionarioState>(
        builder: (context, state) {
          if (state.status == FuncionarioStatus.loading) {
            return const Loading(
              texto: 'Aguarde, carregando dados...',
            );
          } else if (state.status == FuncionarioStatus.initial || controller.state.funcionarios.isEmpty) {
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
                            'Nenhum Funcionario Encontrado',
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
          } else if (state.status == FuncionarioStatus.error) {
            Dialogs.showSnackBar(
              context,
              state.errorMessage ?? '',
              cor: Colors.red,
            );
          }
          return NotificationListener<ScrollNotification>(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
              child: RefreshIndicator(
                onRefresh: onRefresh,
                child: ListViewFuncionarioEquipe(funcionarios: controller.state.funcionarios),
              ),
            ),
          );
        },
      ),
    );
  }
}
