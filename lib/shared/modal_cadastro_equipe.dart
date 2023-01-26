// ignore_for_file: deprecated_member_use
import 'package:app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ModalSheetCadastroEquipe extends StatefulWidget {
  const ModalSheetCadastroEquipe({super.key});

  static Future showModalSheetCadastroEquipe() async {
    return showModalBottomSheet(
      context: App.context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      builder: (context) => const ModalSheetCadastroEquipe(),
    );
  }

  @override
  ModalSheetCadastroEquipeState createState() => ModalSheetCadastroEquipeState();
}

class ModalSheetCadastroEquipeState extends State<ModalSheetCadastroEquipe> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeEquipe = TextEditingController();
  final TextEditingController _idLider = TextEditingController();
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.80,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        child: Container(
          color: const Color(0xFFF7EADC),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Cadastrar Equipe'),
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: const Color(0xFFF7EADC),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _nomeField(),
                      const SizedBox(height: 12.0),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: _idLeaderField(),
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            flex: 7,
                            child: _corField(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: _botaoCadastrar(),
          ),
        ),
      ),
    );
  }

  Widget _nomeField() {
    return TextFormField(
      controller: _nomeEquipe,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.grey[700]),
      decoration: InputDecoration(
        isDense: true,
        label: const Text('Nome da Equipe'),
        floatingLabelStyle: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
        filled: true,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Informe o nome da equipe *';
        }

        return null;
      },
    );
  }

  Widget _idLeaderField() {
    return TextFormField(
      controller: _idLider,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.grey[700]),
      decoration: InputDecoration(
        isDense: true,
        label: const Text('ID Líder'),
        floatingLabelStyle: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
        filled: true,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(4),
      ],
    );
  }

  Widget _corField() {
    return TextFormField(
      initialValue: ' $currentColor',
      readOnly: true,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.grey[700]),
      decoration: InputDecoration(
        isDense: true,
        label: const Text('Cor'),
        floatingLabelStyle: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
        filled: true,
        prefix: Container(
          padding: const EdgeInsets.all(2),
          width: 15.0,
          height: 15.0,
          color: currentColor,
        ),
        suffixIcon: GestureDetector(
          onTap: _showPickerColor,
          child: const Icon(
            Icons.colorize_outlined,
            size: 25.0,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
    );
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  _showPickerColor() {
    return showDialog(
      context: App.context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecione a cor'),
          content: SingleChildScrollView(
            child: ColorPicker(
              showLabel: false,
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Text('Selecionar'),
              onPressed: () {
                setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Widget _botaoCadastrar() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromHeight(55.0),
        foregroundColor: const Color(0xFFF7A94F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
      icon: const Icon(
        Icons.group_add_outlined,
        color: Colors.white,
        size: 30.0,
      ),
      label: const Text(
        'Cadastrar',
        style: TextStyle(fontSize: 22.0, color: Colors.white),
      ),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          Dialogs.showLoadingDialog();
          final data = await CadastroEquipeRepository().cadastroEquipeRepo(_idLider.text, _nomeEquipe.text, currentColor.toString());
          if (data is EquipeModel) {
            Dialogs.showAlertDialog('Cadastro realizado: \n\n${data.id} - ${data.nome}', 'Sucesso').then((_) => Navigator.pop(context));
          }
        }
      },
    );
  }
}
