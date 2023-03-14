import 'package:flutter/material.dart';

import 'package:app/features/pages/shared/rich_text_widget.dart';

class TileSolicitacaoEquipe extends StatelessWidget {
  final String nome;
  final String status;
  final String dataInicial;
  final String dataFinal;
  final String diasAgendados;
  final String? observacaoLider;
  final String? observacaoRh;
  final GestureTapCallback onTap;

  const TileSolicitacaoEquipe({
    Key? key,
    required this.nome,
    required this.status,
    required this.dataInicial,
    required this.dataFinal,
    required this.diasAgendados,
    this.observacaoLider,
    this.observacaoRh,
    required this.onTap,
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
          onTap: onTap,
          child: ListTile(
            contentPadding: const EdgeInsets.all(10.0),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichTextWidget(
                  label: 'Nome:',
                  labeltextStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF3F3F3F),
                    fontWeight: FontWeight.bold,
                  ),
                  text: nome,
                  textStyle: const TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF3F3F3F),
                  ),
                ),
                const SizedBox(height: 5.0),
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
                const SizedBox(height: 3.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichTextWidget(label: 'Status:', text: status),
                      ],
                    ),
                    Visibility(visible: observacaoLider != null, child: RichTextWidget(label: 'Obs. Líder:', text: observacaoLider ?? '')),
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
