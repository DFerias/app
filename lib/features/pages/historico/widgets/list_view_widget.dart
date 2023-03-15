import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/ui/base_state/base_state.dart';
import 'package:app/features/domain/entities/ferias.dart';
import 'package:app/features/pages/historico/cubit/historico_controller.dart';
import 'package:app/features/pages/historico/widgets/tile_solicitacao.dart';
import 'package:app/index.dart';

class ListViewWidget extends StatefulWidget {
  final List<Ferias> listaFerias;
  final int tab;

  const ListViewWidget({
    Key? key,
    required this.listaFerias,
    required this.tab,
  }) : super(key: key);

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends BaseState<ListViewWidget, HistoricoController> {
  Future<void> onRefresh() async {
    controller.loadAllFerias(AuthService.instance.usuario!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoricoController, HistoricoState>(
      builder: (context, state) {
        if (state.status == HistoricoStatus.loading) {
          return const Loading(
            texto: 'Aguarde, carregando dados...',
          );
        } else if (state.status == HistoricoStatus.initial || widget.listaFerias.isEmpty) {
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
        } else if (state.status == HistoricoStatus.error) {
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
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: widget.listaFerias.length,
                itemBuilder: (context, index) {
                  return TileSolicitacao(
                    status: widget.listaFerias[index].status ?? '',
                    dataInicial: widget.listaFerias[index].inicio ?? '',
                    dataFinal: widget.listaFerias[index].fim ?? '',
                    diasAgendados: widget.listaFerias[index].diasAgendados ?? '',
                    observacaoLider: widget.listaFerias[index].observacoesLider,
                    observacaoRh: widget.listaFerias[index].observacoesRh,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
