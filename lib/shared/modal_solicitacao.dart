import 'package:app/index.dart';
import 'package:flutter/material.dart';

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
  final _formKey = GlobalKey<FormState>();
  DateTime? _inicio;
  DateTime? _fim;
  bool? _inicialValido;
  bool? _finalValido;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      child: Container(
        color: const Color(0xFFF7EADC),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
      ),
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
          DatePickerWidget(date: _inicio, dataInicialValid: _inicialValido),
        ],
      ),
      onTap: () {
        DateTimePicker().picker(null).then((value) {
          setState(() {
            _inicio = value;
            _inicialValido = true;
          });
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
          DatePickerWidget(date: _fim, dataFinalValid: _finalValido),
        ],
      ),
      onTap: () {
        DateTimePicker().picker(null).then((value) {
          setState(() {
            _fim = value;
            _finalValido = true;
          });
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
          _validarDataInicial();
          _validarDataFinal();

          if ((_inicialValido != null && _inicialValido == true) && (_finalValido != null && _finalValido == true)) {
            Dialogs.showLoadingDialog();
            SolicitacaoFeriasRepository().solicitacaoFeriasRepo(_inicio, _fim).then((value) {
              if (value is SolicitacaoFeriasModel) {
                Dialogs.showAlertDialog('Cadastro realizado: \n\nSolicitação N.º: ${value.id}\nData inicial: ${value.inicio}\nData final: ${value.fim}', 'Sucesso').then((_) {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                });
              }
            });
          }
        },
      ),
    );
  }

  _validarDataInicial() {
    setState(() {
      if (_inicio != null) {
        _inicialValido = true;
      } else {
        _inicialValido = false;
      }
    });
  }

  _validarDataFinal() {
    setState(() {
      if (_fim != null) {
        _finalValido = true;
      } else {
        _finalValido = false;
      }
    });
  }
}
