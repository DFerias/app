import 'package:app/data/repositories/listar_modalidade_repository.dart';
import 'package:app/index.dart';
import 'package:app/shared/drop_down_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _cidade = TextEditingController();
  final _idEquipe = TextEditingController();

  Map<String, String>? _listaModalidades;

  final _cadFuncionarioBloc = CadastrarFuncionarioBloc();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ListarModalidadeRepository().listarModalidadeRepo().then((value) {
        _listaModalidades = {for (var e in value) e.name: e.id.toString()};
        setState(() {});
      });
    });
    super.initState();
  }

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
            body: BlocBuilder<CadastrarFuncionarioBloc, CadastrarFuncionarioState>(
              bloc: _cadFuncionarioBloc,
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
                    child: _form(state),
                  ),
                );
              },
            ),
            bottomNavigationBar: _botaoCadastrar(),
          ),
        ),
      ),
    );
  }

  Widget _form(CadastrarFuncionarioState state) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _nomeField(),
          const SizedBox(height: 12.0),
          _emailField(),
          const SizedBox(height: 12.0),
          _senhaField(state),
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
            crossAxisAlignment: CrossAxisAlignment.end,
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
    );
  }

  Widget _nomeField() {
    return TextFieldWidget(
      controllerField: _nome,
      keyBoardType: TextInputType.name,
      label: 'Nome',
      textInputAction: TextInputAction.next,
      messageValitador: 'Informe um nome *',
    );
  }

  Widget _emailField() {
    return TextFieldWidget(
      controllerField: _email,
      keyBoardType: TextInputType.emailAddress,
      label: 'Email',
      textInputAction: TextInputAction.next,
      messageValitador: 'Informe um email *',
    );
  }

  Widget _senhaField(CadastrarFuncionarioState state) {
    return TextFieldWidget(
      controllerField: _senha,
      keyBoardType: TextInputType.text,
      label: 'Senha',
      textInputAction: TextInputAction.next,
      messageValitador: 'Informe uma senha *',
      obscureText: !state.passVisible!,
      suffixIcon: GestureDetector(
        child: state.passVisible ?? false ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
        onTap: () => _cadFuncionarioBloc.add(PassVisibleEvent()),
      ),
    );
  }

  Widget _cidadeField() {
    return TextFieldWidget(
      controllerField: _cidade,
      keyBoardType: TextInputType.name,
      label: 'Cidade',
      textInputAction: TextInputAction.next,
      messageValitador: 'Informe uma cidade *',
    );
  }

  Widget _ufField() {
    return DropDownButton(
      label: 'UF',
      lista: _cadFuncionarioBloc.state.listaUfs,
      value: _cadFuncionarioBloc.state.uf,
      validate: _cadFuncionarioBloc.state.validarUf,
      onChanged: (value) {
        _cadFuncionarioBloc.add(SelectUfEvent(uf: value));
        _cadFuncionarioBloc.add(ValidarUfEvent());
      },
    );
  }

  Widget _idEquipeField() {
    return TextFormField(
      controller: _idEquipe,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.grey[700]),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        isDense: true,
        label: const Text('ID'),
        floatingLabelStyle: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
        filled: true,
        fillColor: const Color(0xFFE5DACC),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Informe o ID da equipe *';
        }

        return null;
      },
    );
  }

  Widget _modalidadeField() {
    return DropDownButton(
      label: 'Modalidade',
      lista: _listaModalidades,
      value: _cadFuncionarioBloc.state.modalidade,
      validate: _cadFuncionarioBloc.state.validarModalidade,
      onChanged: (value) {
        _cadFuncionarioBloc.add(SelectModalidadeEvent(modalidade: value));
        _cadFuncionarioBloc.add(ValidarModalidadeEvent());
      },
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
          DatePickerWidget(date: _cadFuncionarioBloc.state.dataAdmissao, dataFinalValid: _cadFuncionarioBloc.state.validarData),
        ],
      ),
      onTap: () {
        DateTimePicker().picker(DateTime(2005)).then((value) {
          setState(() {
            primaryFocus!.unfocus();
            _cadFuncionarioBloc.add(SelectDataAdmissaoEvent(dataAdmissao: value));
            _cadFuncionarioBloc.add(ValidarDataEvent());
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
      onPressed: () async {
        _cadFuncionarioBloc.add(FinalizarCadastroEvent(
          funcionario: FuncionarioModel(
            formKey: _formKey,
            nome: _nome.text,
            email: _email.text,
            senha: _senha.text,
            cidade: _cidade.text,
            idEquipe: _idEquipe.text.isNotEmpty ? int.parse(_idEquipe.text) : null,
            uf: _cadFuncionarioBloc.state.uf,
            modalidade: _cadFuncionarioBloc.state.modalidade,
            dataAdmissao: _cadFuncionarioBloc.state.dataAdmissao,
          ),
        ));
      },
    );
  }
}
