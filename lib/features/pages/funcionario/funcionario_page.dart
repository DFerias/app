import 'package:app/core/ui/base_state/base_state.dart';
import 'package:app/features/pages/equipe/equipe_controller/equipe_controller.dart';
import 'package:app/features/pages/funcionario/cubit/lista_funcionario_cubit/funcionario_controller.dart';
import 'package:app/features/pages/funcionario/widgets/list_view_funcionario.dart';
import 'package:app/features/pages/shared/dferias_appbar.dart';
import 'package:app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FuncionarioPage extends StatefulWidget {
  const FuncionarioPage({super.key});

  @override
  State<FuncionarioPage> createState() => _FuncionarioPageState();
}

class _FuncionarioPageState extends BaseState<FuncionarioPage, FuncionarioController> {
  @override
  void onReady() {
    super.onReady();

    controller.getFuncionarios();
    context.read<EquipeController>().getEquipes();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> onRefresh() async {
      controller.getFuncionarios();
    }

    return Scaffold(
      appBar: DFeriasAppbar(title: 'Funcionários'),
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
                child: ListViewFuncionario(lista: controller.state.funcionarios),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.person_add_outlined,
          color: Colors.white,
        ),
        onPressed: () => ModalSheetCadastroFuncionario.showModalSheetCadastroFuncionario().then((value) {
          if (value == true) {
            onRefresh();
          }
        }),
      ),
    );
  }
}
