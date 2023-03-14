import 'package:app/features/domain/entities/ferias.dart';
import 'package:app/features/pages/historico/widgets/modal_info_solicitacao.dart';
import 'package:flutter/material.dart';

import 'package:app/features/pages/shared/rich_text_widget.dart';

class TileSolicitacao extends StatelessWidget {
  final String status;
  final String dataInicial;
  final String dataFinal;
  final String diasAgendados;
  final String? observacaoLider;
  final String? observacaoRh;

  const TileSolicitacao({
    Key? key,
    required this.status,
    required this.dataInicial,
    required this.dataFinal,
    required this.diasAgendados,
    this.observacaoLider,
    this.observacaoRh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    statusColor() {
      if (status == 'PENDENTE') {
        return Colors.yellow[800];
      } else if (status == 'RECUSADA') {
        return Colors.red;
      } else if (status == 'VALIDADA') {
        return Colors.green;
      } else if (status == 'APROVADA') {
        return const Color(0xff186CB1);
      } else {
        return Colors.green[900];
      }
    }

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 3.0,
      child: Ink(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: statusColor()!, width: 6.0),
          ),
        ),
        child: InkWell(
          onTap: () => ModalInfoSolicitacao.showModalSheetInfoSolicitacao(
            context,
            Ferias(
              status: status,
              inicio: dataInicial,
              fim: dataFinal,
              diasAgendados: diasAgendados,
              observacoesLider: observacaoLider,
              observacoesRh: observacaoRh,
            ),
          ),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichTextWidget(
                  label: 'Status:',
                  labeltextStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF3F3F3F),
                    fontWeight: FontWeight.bold,
                  ),
                  text: status,
                  textStyle: const TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF3F3F3F),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Qtd. de dias: ',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3F3F3F),
                        ),
                      ),
                      TextSpan(
                        text: diasAgendados,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF3F3F3F),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 3.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichTextWidget(label: 'Início:', text: dataInicial),
                    RichTextWidget(label: 'Fim:', text: dataFinal),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 3.0),
                    Visibility(visible: observacaoLider != null, child: RichTextWidget(label: 'Obs. Líder:', text: observacaoLider ?? '')),
                    const SizedBox(height: 3.0),
                    Visibility(visible: observacaoRh != null, child: RichTextWidget(label: 'Obs. RH:', text: observacaoRh ?? '')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
