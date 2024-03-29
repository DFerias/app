import 'package:app/core/ui/base_state/base_state.dart';
import 'package:app/features/pages/shared/button_widget.dart';
import 'package:app/features/pages/solicitacao/widgets/text_field_observacao.dart';
import 'package:app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/features/data/dto/solicitacao_ferias_dto.dart';
import 'package:app/features/pages/shared/rich_text_widget.dart';
import 'package:app/features/pages/solicitacao/solicitacao_controller/solicitacao_equipe_controller.dart';

class ModalValidacao extends StatefulWidget {
  final BuildContext context;
  final SolicitacaoFeriasDto solicitacao;

  const ModalValidacao({
    Key? key,
    required this.context,
    required this.solicitacao,
  }) : super(key: key);

  static Future showModalSheetValidacao(BuildContext context, SolicitacaoFeriasDto solicitacao) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      builder: (context) => BlocProvider(
        create: (context) => SolicitacaoEquipeController(),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ModalValidacao(context: context, solicitacao: solicitacao),
        ),
      ),
    );
  }

  @override
  State<ModalValidacao> createState() => _ModalValidacaoState();
}

class _ModalValidacaoState extends BaseState<ModalValidacao, SolicitacaoEquipeController> {
  final _observacao = TextEditingController();
  final ScrollController _scrollControllerText = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SolicitacaoEquipeController, SolicitacaoEquipeState>(
      listener: (context, state) {
        if (state.status == SolicitacaoEquipeStatus.loading) {
          Dialogs.showLoadingDialog();
        }

        if (state.status == SolicitacaoEquipeStatus.success) {
          Dialogs.close();
          Dialogs.showAlertDialog('${state.successMessage}', 'Sucesso!').then((_) => Navigator.pop(context, true));
        }

        if (state.status == SolicitacaoEquipeStatus.error) {
          Dialogs.showAlertDialog(state.errorMessage, 'Atenção!').then((_) => Dialogs.close());
        }
      },
      child: ClipRRect(
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
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichTextWidget(
                    label: 'Nome:',
                    labeltextStyle: const TextStyle(fontSize: 18.0, color: Color(0xFF3F3F3F), fontWeight: FontWeight.bold),
                    text: widget.solicitacao.funcionario?.nome ?? '',
                    textStyle: const TextStyle(fontSize: 16.0, color: Color(0xFF3F3F3F)),
                  ),
                  Visibility(
                    visible: widget.solicitacao.ferias?.id != null,
                    child: RichTextWidget(
                      label: '#',
                      text: widget.solicitacao.ferias!.id.toString(),
                      labeltextStyle: const TextStyle(fontSize: 18.0, color: Color(0xFF3F3F3F), fontWeight: FontWeight.bold),
                      textStyle: const TextStyle(fontSize: 16.0, color: Color(0xFF3F3F3F)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichTextWidget(label: 'Início:', text: widget.solicitacao.ferias?.inicio ?? ''),
                  RichTextWidget(label: 'Fim:', text: widget.solicitacao.ferias?.fim ?? ''),
                ],
              ),
              const SizedBox(height: 8.0),
              TextFieldObservacao(
                scrollController: _scrollControllerText,
                textEditingController: _observacao,
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ButtonWidget(
                      label: const Text('Recusar', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFFF8D06))),
                      icon: const Icon(
                        Icons.block,
                        color: Color(0xFFFF8D06),
                      ),
                      backgroundColor: const Color.fromARGB(255, 252, 230, 202),
                      onPressed: () => controller.changeStatusFeriasEquipe(widget.solicitacao.ferias!.id!, 'RECUSADA'),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: ButtonWidget(
                      label: const Text('Validar', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                      icon: const Icon(Icons.done),
                      onPressed: () => controller.changeStatusFeriasEquipe(widget.solicitacao.ferias!.id!, 'VALIDADA'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
