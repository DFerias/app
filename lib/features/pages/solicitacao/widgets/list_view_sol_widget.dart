import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/core/ui/base_state/base_state.dart';
import 'package:app/features/data/dto/solicitacao_ferias_dto.dart';
import 'package:app/features/pages/solicitacao/solicitacao_controller/solicitacao_equipe_controller.dart';
import 'package:app/features/pages/solicitacao/widgets/modal_validacao.dart';
import 'package:app/features/pages/solicitacao/widgets/tile_solicitacao_equipe.dart';
import 'package:app/index.dart';

class ListViewSolWidget extends StatefulWidget {
  final List<SolicitacaoFeriasDto> listaSolFerias;
  final bool isRh;

  const ListViewSolWidget({
    Key? key,
    required this.listaSolFerias,
    required this.isRh,
  }) : super(key: key);

  @override
  State<ListViewSolWidget> createState() => _ListViewSolWidgetState();
}

class _ListViewSolWidgetState extends BaseState<ListViewSolWidget, SolicitacaoEquipeController> {
  Future<void> onRefresh() async {
    if (widget.isRh) {
      controller.loadFeriasValidadas();
    } else {
      controller.loadFeriasEquipe();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitacaoEquipeController, SolicitacaoEquipeState>(
      builder: (context, state) {
        if (state.status == SolicitacaoEquipeStatus.loading) {
          return const Loading(
            texto: 'Aguarde, carregando dados...',
          );
        } else if (state.status == SolicitacaoEquipeStatus.initial || widget.listaSolFerias.isEmpty) {
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
        } else if (state.status == SolicitacaoEquipeStatus.error) {
          log(state.errorMessage ?? '');
        }

        return NotificationListener<ScrollNotification>(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
            child: RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: widget.listaSolFerias.length,
                itemBuilder: (context, index) {
                  return TileSolicitacaoEquipe(
                    nome: widget.listaSolFerias[index].funcionario?.nome ?? '',
                    status: widget.listaSolFerias[index].ferias?.status ?? '',
                    dataInicial: widget.listaSolFerias[index].ferias?.inicio ?? '',
                    dataFinal: widget.listaSolFerias[index].ferias?.fim ?? '',
                    diasAgendados: widget.listaSolFerias[index].ferias?.diasAgendados ?? '',
                    observacaoLider: widget.listaSolFerias[index].ferias?.observacoesLider,
                    observacaoRh: widget.listaSolFerias[index].ferias?.observacoesRh,
                    onTap: () => ModalValidacao.showModalSheetValidacao(context, widget.listaSolFerias[index], widget.isRh).then((value) {
                      if (value == true) {
                        if (widget.isRh) {
                          controller.loadFeriasValidadas();
                        } else {
                          controller.loadFeriasEquipe();
                        }
                      }
                    }),
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
