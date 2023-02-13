// ignore_for_file: unrelated_type_equality_checks

import 'package:app/core/ui/base_state/base_state.dart';
import 'package:app/index.dart';
import 'package:app/features/pages/shared/drop_down_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

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

class ModalSheetCadastroFuncionarioState extends BaseState<ModalSheetCadastroFuncionario, CadastrarFuncionarioController> {
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _cidade = TextEditingController();
  final _idEquipe = TextEditingController();

  // Map<String, String>? _listaModalidades;

  @override
  void onReady() {
    super.onReady();

    controller.listarModalidades();
  }

  /* @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /* await ModalidadeRepository().listarModalidadeRepo().then((value) {
        _listaModalidades = {for (var e in value) e.name: e.id.toString()};
        setState(() {});
      }); */
    });
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.90,
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
            body: BlocConsumer<CadastrarFuncionarioController, CadastrarFuncionarioState>(
              listener: (context, state) {
                if (state.status == CadastrarFuncionarioStatus.loading) {
                  Dialogs.showLoadingDialog();
                }

                if (state.status == CadastrarFuncionarioStatus.sucess) {
                  Dialogs.close();
                  Dialogs.showAlertDialog('Usuário ${state.funcionario?.nome} foi cadastrado com sucesso!', 'Sucesso!');
                }

                if (state.status == CadastrarFuncionarioStatus.error) {
                  // Dialogs.close();
                  Dialogs.showAlertDialog(state.errorMessage, 'Atenção!').then((_) => Dialogs.close());
                }
              },
              buildWhen: (previous, current) {
                bool teste = false;

                if (previous != current) {
                  if (current != CadastrarFuncionarioStatus.error) {
                    teste = true;
                  }

                  if (current != CadastrarFuncionarioStatus.loading) {
                    teste = true;
                  }

                  if (current != CadastrarFuncionarioStatus.sucess) {
                    teste = true;
                  }
                }

                return teste;
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFieldWidget(
                            controllerField: _nome,
                            keyBoardType: TextInputType.name,
                            label: 'Nome',
                            textInputAction: TextInputAction.next,
                            validator: Validatorless.required('Nome Obrigatório *'),
                          ),
                          const SizedBox(height: 12.0),
                          TextFieldWidget(
                            controllerField: _email,
                            keyBoardType: TextInputType.emailAddress,
                            label: 'Email',
                            textInputAction: TextInputAction.next,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required('E-mail Obrigatório *'),
                                Validatorless.email('E-mail inválido *'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          TextFieldWidget(
                            controllerField: _senha,
                            keyBoardType: TextInputType.text,
                            label: 'Senha',
                            textInputAction: TextInputAction.next,
                            validator: Validatorless.required('Senha Obrigatória *'),
                            obscureText: !controller.state.passVisible!,
                            suffixIcon: GestureDetector(
                              child: controller.state.passVisible ?? false ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                              onTap: () {
                                // controller.add(PassVisibleEvent());
                              },
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          TextFieldWidget(
                            controllerField: _cidade,
                            keyBoardType: TextInputType.name,
                            label: 'Cidade',
                            textInputAction: TextInputAction.next,
                            validator: Validatorless.required('Cidade Obrigatória *'),
                          ),
                          const SizedBox(height: 12.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 3,
                                child: TextFieldWidget(
                                  controllerField: _idEquipe,
                                  keyBoardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  label: 'ID Equipe',
                                  validator: Validatorless.required('ID Equipe Obrigatório'),
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                flex: 3,
                                child: DropDownButton(
                                  label: 'UF',
                                  lista: utilListaUFs,
                                  value: controller.state.uf,
                                  validate: controller.state.validarUf,
                                  messageValidate: 'UF Obrigatória *',
                                  onChanged: (value) {
                                    // _cadFuncionarioBloc.add(SelectUfEvent(uf: value));
                                    // _cadFuncionarioBloc.add(ValidarUfEvent());
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          DropDownButton(
                            label: 'Modalidade',
                            lista: {for (var v in controller.state.listaModalidades) v.id.toString(): v.name!},
                            value: controller.state.modalidade,
                            validate: controller.state.validarModalidade,
                            messageValidate: 'Modalidade Obrigatória *',
                            onChanged: (value) {
                              // _cadFuncionarioBloc.add(SelectModalidadeEvent(modalidade: value));
                              // _cadFuncionarioBloc.add(ValidarModalidadeEvent());
                            },
                          ),
                          const SizedBox(height: 12.0),
                          DatePickerWidget(
                            label: 'Data de Admissão',
                            date: controller.state.dataAdmissao,
                            dataFinalValid: controller.state.validarData,
                            onTap: () {
                              DateTimePicker().picker(DateTime(2005)).then((value) {
                                setState(() {
                                  primaryFocus!.unfocus();
                                  // _cadFuncionarioBloc.add(SelectDataAdmissaoEvent(dataAdmissao: value));
                                  // _cadFuncionarioBloc.add(ValidarDataEvent());
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ),
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
        /* _cadFuncionarioBloc.add(
          FinalizarCadastroEvent(
            funcionario: FuncionarioModel(
              nome: _nome.text,
              email: _email.text,
              senha: _senha.text,
              cidade: _cidade.text,
              idEquipe: _idEquipe.text.isNotEmpty ? int.parse(_idEquipe.text) : null,
              uf: _cadFuncionarioBloc.state.uf,
              modalidade: _cadFuncionarioBloc.state.modalidade,
              dataAdmissao: _cadFuncionarioBloc.state.dataAdmissao,
            ),
          ),
        ); */
      },
    );
  }
}
