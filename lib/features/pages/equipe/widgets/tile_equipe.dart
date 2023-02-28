import 'package:app/features/pages/shared/rich_text_widget.dart';
import 'package:flutter/material.dart';

class TileEquipe extends StatelessWidget {
  const TileEquipe({super.key});

  @override
  Widget build(BuildContext context) {
    /* statusColor() {
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
    } */

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 3.0,
      child: Ink(
        decoration: const BoxDecoration(
          border: Border(
              // left: BorderSide(color: statusColor()!, width: 6.0),
              ),
        ),
        child: InkWell(
          onTap: () {},
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                RichTextWidget(
                  label: 'Status:',
                  labeltextStyle: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF3F3F3F),
                    fontWeight: FontWeight.bold,
                  ),
                  text: 'Teste',
                  textStyle: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF3F3F3F),
                  ),
                ),
                Visibility(
                  visible: true,
                  child: RichTextWidget(
                    label: '#',
                    text: 'id',
                    labeltextStyle: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF3F3F3F),
                      fontWeight: FontWeight.bold,
                    ),
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF3F3F3F),
                    ),
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
                  children: const [
                    // RichTextWidget(label: 'Início:', text: dataInicial),
                    // RichTextWidget(label: 'Fim:', text: dataFinal),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    // Visibility(visible: observacaoLider != null, child: RichTextWidget(label: 'Obs. Líder:', text: observacaoLider ?? '')),
                    // Visibility(visible: observacaoRh != null, child: RichTextWidget(label: 'Obs. RH:', text: observacaoRh ?? '')),
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
