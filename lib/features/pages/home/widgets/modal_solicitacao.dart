import 'package:app/features/pages/funcionario/cubit/lista_funcionario_cubit/funcionario_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/core/ui/base_state/base_state.dart';
import 'package:app/features/domain/entities/ferias.dart';
import 'package:app/features/pages/home/bloc/solicitacao_controller/solicitacao_controller.dart';
import 'package:app/index.dart';

class ModalSheetSolicitacao extends StatefulWidget {
  final String rota;

  const ModalSheetSolicitacao({
    Key? key,
    required this.rota,
  }) : super(key: key);

  static Future showModalSheetSolicitacao(String rota) async {
    return showModalBottomSheet(
      context: App.context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SolicitacaoController()),
          BlocProvider(create: (context) => FuncionarioController()),
        ],
        child: ModalSheetSolicitacao(rota: rota),
      ),
    );
  }

  @override
  ModalSheetSolicitacaoState createState() => ModalSheetSolicitacaoState();
}

class ModalSheetSolicitacaoState extends BaseState<ModalSheetSolicitacao, SolicitacaoController> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _inicio;
  DateTime? _fim;
  bool? _inicialValido;
  bool? _finalValido;

  @override
  void onReady() {
    super.onReady();
    context.read<FuncionarioController>().getFuncionariosId(AuthService.instance.usuario!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SolicitacaoController, SolicitacaoState>(
          listener: (context, state) {
            if (state.status == SolicitacaoStatus.loading) {
              Dialogs.showLoadingDialog();
            }

            if (state.status == SolicitacaoStatus.error) {
              Dialogs.showAlertDialog(state.errorMessage, 'Atenção!').then((_) => Dialogs.close());
            }

            if (state.status == SolicitacaoStatus.success) {
              Dialogs.showAlertDialog(state.successMessage, 'Sucesso').then((_) {
                Navigator.pop(context);
                if (widget.rota == '/home') {
                  Navigator.of(context).pushNamedAndRemoveUntil(widget.rota, (Route<dynamic> route) => false);
                } else {
                  Navigator.pop(context, true);
                }
              });
            }
          },
        ),
        BlocListener<FuncionarioController, FuncionarioState>(
          listener: (context, state) {
            if (state.status == FuncionarioStatus.loading) {
              Dialogs.showLoadingDialog();
            }

            if (state.status == FuncionarioStatus.error) {
              Dialogs.showAlertDialog(state.errorMessage, 'Atenção!').then((_) => Dialogs.close());
            }

            if (state.status == FuncionarioStatus.loaded) {
              Dialogs.close();
            }
          },
        ),
      ],
      child: ClipRRect(
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
                  const SizedBox(height: 10.0),
                  BlocBuilder<FuncionarioController, FuncionarioState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Saldo de Férias:',
                            style: TextStyle(fontSize: 16.0, color: Color(0xFF3F3F3F), fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${_subtrairDiasAgendadosDoSaldo()} dias',
                            style: const TextStyle(fontSize: 16.0, color: Color(0xFF3F3F3F)),
                          )
                        ],
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Dias Agendados: ',
                        style: TextStyle(fontSize: 16.0, color: Color(0xFF3F3F3F), fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${_calcularDiasAgendados()} dias',
                        style: const TextStyle(fontSize: 16.0, color: Color(0xFF3F3F3F)),
                      )
                    ],
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
      ),
    );
  }

  Widget _dataInicio() {
    return DatePickerWidget(
      label: 'Data Inicial',
      date: _inicio,
      dataInicialValid: _inicialValido,
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
    var dataInicial = _inicio?.add(const Duration(days: 5));

    return DatePickerWidget(
      label: 'Data Final',
      date: _fim,
      dataFinalValid: _finalValido,
      onTap: () {
        DateTimePicker().picker(dataInicial, initial: dataInicial).then((value) {
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
          _enviar();
        },
      ),
    );
  }

  void _enviar() {
    _validarDataInicial();
    _validarDataFinal();

    if ((_inicialValido != null && _inicialValido == true) && (_finalValido != null && _finalValido == true)) {
      controller.addSolicitacao(Ferias(inicio: _inicio.toString(), fim: _fim.toString()));
    }
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

  _calcularDiasAgendados() {
    if (_inicio != null && _fim != null) {
      Duration diferenca = _fim!.difference(_inicio!);
      return diferenca.inDays.toString();
    } else {
      return '0';
    }
  }

  _subtrairDiasAgendadosDoSaldo() {
    if (_inicio != null && _fim != null) {
      Duration diferenca = _fim!.difference(_inicio!);
      var saldo = AuthService.instance.usuario?.saldoFerias ?? 0;

      return saldo - diferenca.inDays;
    } else {
      return AuthService.instance.usuario?.saldoFerias ?? 0;
    }
  }
}
