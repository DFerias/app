import 'package:app/index.dart';
import 'package:flutter/material.dart';

class ModalSheetCadastroFuncionario extends StatefulWidget {
  const ModalSheetCadastroFuncionario({super.key});

  static Future showModalSheetCadastroFuncionario() async {
    return showModalBottomSheet(
      context: App.context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      builder: (context) => const ModalSheetCadastroFuncionario(),
    );
  }

  @override
  ModalSheetCadastroFuncionarioState createState() => ModalSheetCadastroFuncionarioState();
}

class ModalSheetCadastroFuncionarioState extends State<ModalSheetCadastroFuncionario> {
  DateTime? _dataAdmis;

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
              title: const Text('Cadastrar Funcionário'),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _nomeField(),
                    const SizedBox(height: 12.0),
                    _emailField(),
                    const SizedBox(height: 12.0),
                    _senhaField(),
                    const SizedBox(height: 12.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: _cidadeField(),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          flex: 2,
                          child: _ufField(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: _idEquipeField(),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          flex: 7,
                          child: _modalidadeField(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    _dataAdmissao(),
                  ],
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
      controller: null,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.grey[700]),
      decoration: InputDecoration(
        isDense: true,
        label: const Text('Nome'),
        floatingLabelStyle: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
        filled: true,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: null,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.grey[700]),
      decoration: InputDecoration(
        isDense: true,
        label: const Text('E-mail'),
        floatingLabelStyle: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
        filled: true,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
    );
  }

  Widget _senhaField() {
    return TextFormField(
      controller: null,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.grey[700]),
      decoration: InputDecoration(
        isDense: true,
        label: const Text('Senha'),
        floatingLabelStyle: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
        filled: true,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
    );
  }

  Widget _cidadeField() {
    return TextFormField(
      controller: null,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.grey[700]),
      decoration: InputDecoration(
        isDense: true,
        label: const Text('Cidade'),
        floatingLabelStyle: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
        filled: true,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
    );
  }

  Widget _ufField() {
    return TextFormField(
      controller: null,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.grey[700]),
      decoration: InputDecoration(
        isDense: true,
        label: const Text('UF'),
        floatingLabelStyle: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
        filled: true,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
    );
  }

  Widget _idEquipeField() {
    return TextFormField(
      controller: null,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.grey[700]),
      decoration: InputDecoration(
        isDense: true,
        label: const Text('ID'),
        floatingLabelStyle: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
        filled: true,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
    );
  }

  Widget _modalidadeField() {
    return TextFormField(
      controller: null,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.grey[700]),
      decoration: InputDecoration(
        isDense: true,
        label: const Text('Modalidade'),
        floatingLabelStyle: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
        filled: true,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
    );
  }

  Widget _dataAdmissao() {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Data de Admissão',
            style: TextStyle(
              color: Color(0xFF3F3F3F),
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2.0),
          DatePickerWidget(date: _dataAdmis),
        ],
      ),
      onTap: () {
        DateTimePicker().picker(DateTime(2005)).then((value) {
          setState(() {
            _dataAdmis = value;
          });
        });
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
        Icons.person_add_outlined,
        color: Colors.white,
        size: 30.0,
      ),
      label: const Text(
        'Cadastrar',
        style: TextStyle(fontSize: 22.0, color: Colors.white),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
