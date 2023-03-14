import 'package:app/features/pages/historico/widgets/text_container.dart';
import 'package:app/features/pages/shared/rich_text_widget.dart';
import 'package:flutter/material.dart';

import 'package:app/features/domain/entities/ferias.dart';

class ModalInfoSolicitacao extends StatefulWidget {
  final Ferias infoFerias;

  const ModalInfoSolicitacao({
    Key? key,
    required this.infoFerias,
  }) : super(key: key);

  static Future showModalSheetInfoSolicitacao(BuildContext context, Ferias infoFerias) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      builder: (context) => ModalInfoSolicitacao(infoFerias: infoFerias),
    );
  }

  @override
  State<ModalInfoSolicitacao> createState() => _ModalInfoSolicitacaoState();
}

class _ModalInfoSolicitacaoState extends State<ModalInfoSolicitacao> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      child: Container(
        color: const Color(0xFFF7EADC),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 5.0,
              width: 75.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichTextWidget(
                  label: 'Status:',
                  labeltextStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF3F3F3F),
                    fontWeight: FontWeight.bold,
                  ),
                  text: widget.infoFerias.status,
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
                        text: widget.infoFerias.diasAgendados,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 3.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichTextWidget(label: 'Início:', text: widget.infoFerias.inicio),
                    RichTextWidget(label: 'Fim:', text: widget.infoFerias.fim),
                  ],
                ),
                const SizedBox(height: 8.0),
                Visibility(
                  visible: widget.infoFerias.observacoesLider != null,
                  child: TextContainer(
                    label: 'Observação Líder',
                    observacao: widget.infoFerias.observacoesLider,
                  ),
                ),
                const SizedBox(height: 8.0),
                Visibility(
                  visible: widget.infoFerias.observacoesRh != null,
                  child: TextContainer(
                    label: 'Observação RH',
                    observacao: widget.infoFerias.observacoesRh,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
