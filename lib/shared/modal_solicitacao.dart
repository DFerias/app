import 'package:app/index.dart';
import 'package:app/shared/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModalSheetSolicitacao extends StatefulWidget {
  const ModalSheetSolicitacao({super.key});

  static Future showModalSheetSolicitacao() async {
    return showModalBottomSheet(
      context: App.context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      builder: (context) => const ModalSheetSolicitacao(),
    );
  }

  @override
  ModalSheetSolicitacaoState createState() => ModalSheetSolicitacaoState();
}

class ModalSheetSolicitacaoState extends State<ModalSheetSolicitacao> {
  late DataSolicitacaoBloc _solicitacaoBloc;

  @override
  void initState() {
    _solicitacaoBloc = DataSolicitacaoBloc();
    super.initState();
  }

  @override
  void dispose() {
    _solicitacaoBloc.add(CleanEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataSolicitacaoBloc, DataSolicitacaoState>(
      bloc: _solicitacaoBloc,
      builder: (context, state) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          child: Container(
            color: const Color(0xFFF7EADC),
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
            child: SingleChildScrollView(
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
                  const SizedBox(height: 8.0),
                  const Text(
                    'Nova Solicitação',
                    style: TextStyle(color: Color(0xFF3F3F3F), fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  _dataInicio(),
                  const SizedBox(height: 10.0),
                  _dataFim(),
                  const SizedBox(height: 30.0),
                  _buttonFinalizar()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _dataInicio() {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Data Inicial',
            style: TextStyle(
              color: Color(0xFF3F3F3F),
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2.0),
          DatePickerWidget(dataInicio: true, date: _solicitacaoBloc.state.dataInicial)
        ],
      ),
      onTap: () {
        DateTimePicker().picker(null).then((value) {
          _solicitacaoBloc.add(SelectDataInicialEvent(dataInicio: value));
        });
      },
    );
  }

  Widget _dataFim() {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Data Final',
            style: TextStyle(
              color: Color(0xFF3F3F3F),
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2.0),
          DatePickerWidget(dataInicio: false, date: _solicitacaoBloc.state.dataFinal),
        ],
      ),
      onTap: () {
        DateTimePicker().picker(null).then((value) {
          _solicitacaoBloc.add(SelectDataFinalEvent(dataFinal: value));
        });
      },
    );
  }

  Widget _buttonFinalizar() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: ElevatedButton(
        child: const Text(
          'Enviar Solicitação',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
