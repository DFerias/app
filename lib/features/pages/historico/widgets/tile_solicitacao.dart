import 'package:flutter/material.dart';

import 'package:app/features/pages/shared/rich_text_widget.dart';

class TileSolicitacao extends StatelessWidget {
  final String status;
  final String dataInicial;
  final String dataFinal;
  final String? observacaoLider;
  final String? observacaoRh;

  const TileSolicitacao({
    Key? key,
    required this.status,
    required this.dataInicial,
    required this.dataFinal,
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
          onTap: () {},
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
