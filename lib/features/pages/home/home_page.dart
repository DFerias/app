import 'package:app/features/data/dto/solicitacao_ferias_dto.dart';
import 'package:app/features/domain/entities/equipe.dart';
import 'package:app/features/pages/equipe/equipe_controller/equipe_controller.dart';
import 'package:app/features/pages/shared/rounded_button_widget.dart';
import 'package:app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<SolicitacaoFeriasDto>>? future;
  late SolicitacaoFeriasDto solFerias;
  List<Widget> listaBotoes = [];
  late final ListarFeriasController feriasController;
  late final EquipeController equipeController;

  @override
  void initState() {
    feriasController = ListarFeriasController();
    equipeController = EquipeController();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      equipeController.getEquipes().whenComplete(() => feriasController.loadFerias());
    });
  }

  Future<void> onRefresh() async {
    await equipeController.getEquipes();
    await feriasController.loadFerias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20.0, 40.0, 0, 20.0),
            alignment: Alignment.centerLeft,
            color: const Color(0xFFFE9822),
            constraints: const BoxConstraints.expand(height: 150.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      _circleAvatar(),
                      const SizedBox(width: 10.0),
                      _displayInfoUser(),
                    ],
                  ),
                ),
                Expanded(child: _buttonLogOut()),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            flex: 2,
            child: _listIconButtons(),
          ),
          Expanded(
            flex: 9,
            child: _quadroGeralFerias(),
          ),
        ],
      ),
      bottomNavigationBar: _botaoNovaSolicitacao(),
    );
  }

  Widget _circleAvatar() {
    return const CircleAvatar(
      radius: 25.0,
      backgroundColor: Color(0xFFF2F2F2),
      child: Icon(
        Icons.person_outline,
        color: Color(0xFFFE9822),
        size: 30.0,
      ),
    );
  }

  Widget _displayInfoUser() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(text: 'Bem-vindo(a), ', style: TextStyle(fontSize: 16.0)),
              TextSpan(text: App.authService.usuario?.nome.toString(), style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Text('${App.authService.usuario?.modalidade} - Bsoft One', style: const TextStyle(fontSize: 16.0)),
      ],
    );
  }

  Widget _buttonLogOut() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          label: const Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Text(
              'Sair',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          icon: const Icon(Icons.logout_outlined, color: Colors.white),
          onPressed: () {
            Dialogs.showConfirmDialog('Deseja realmente sair?', 'Sair').then((value) {
              if (value == true) {
                Dialogs.showLoadingDialog(mensagem: 'Saindo...');
                Future.delayed(
                  const Duration(milliseconds: 500),
                  () {
                    Dialogs.close();
                    App.authService.logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                  },
                );
              }
            });
          },
        ),
      ],
    );
  }

  Widget _listIconButtons() {
    List listaBotoes = [];

    if (AuthService.instance.authRh == true) {
      listaBotoes = botoesRh();
    } else if (AuthService.instance.isLider == true) {
      listaBotoes = botoesLider();
    } else {
      listaBotoes = botoesColaborador();
    }

    return ListView.builder(
      itemCount: listaBotoes.length,
      itemExtent: 75.0,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return listaBotoes[index];
      },
    );
  }

  Widget _quadroGeralFerias() {
    return Container(
      constraints: const BoxConstraints.expand(height: double.infinity),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        color: Color(0xFFF1E1C8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          children: [
            const SizedBox(height: 5.0),
            const Text(
              'Quadro de Férias Agendadas',
              style: TextStyle(fontSize: 18.0, color: Color(0xFF3F3F3F)),
            ),
            const SizedBox(height: 5.0),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                child: Scrollbar(
                  child: RefreshIndicator(
                    onRefresh: onRefresh,
                    child: BlocBuilder<ListarFeriasController, ListarFeriasState>(
                      bloc: feriasController,
                      builder: (context, state) {
                        return _loadingSolicitacoes(state);
                      },
                    ),
                  ),
                ),
                onNotification: (notification) {
                  return false;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  botoesColaborador() {
    List<Widget> listaWidget = [
      RoundedButtonWidget(icone: Icons.history_outlined, label: 'Histórico', onPressed: () => Navigator.pushNamed(context, '/home/historico')),
      // RoundedButtonWidget(icone: Icons.calendar_month, label: 'Quadro \nde Férias', onPressed: () {}),
    ];

    return listaWidget;
  }

  botoesLider() {
    List<Widget> listaWidget = [
      RoundedButtonWidget(icone: Icons.history_outlined, label: 'Histórico', onPressed: () => Navigator.pushNamed(context, '/home/historico')),
      // RoundedButtonWidget(icone: Icons.calendar_month, label: 'Quadro \nde Férias', onPressed: () {}),
      RoundedButtonWidget(icone: Icons.checklist_outlined, label: 'Solicitações', onPressed: () => Navigator.of(context).pushNamed('/home/solicitacao')),
    ];

    return listaWidget;
  }

  botoesRh() {
    List<Widget> listaWidget = [
      RoundedButtonWidget(icone: Icons.history_outlined, label: 'Histórico', onPressed: () => Navigator.pushNamed(context, '/home/historico')),
      // RoundedButtonWidget(icone: Icons.calendar_month, label: 'Quadro \nde Férias', onPressed: () {}),
      RoundedButtonWidget(icone: Icons.checklist_outlined, label: 'Solicitações', onPressed: () => Navigator.pushNamed(context, '/home/solicitacao')),
      RoundedButtonWidget(icone: Icons.group_outlined, label: 'Equipes', onPressed: () => Navigator.pushNamed(context, '/home/equipe')),
      RoundedButtonWidget(icone: Icons.person, label: 'Funcionarios', onPressed: () => Navigator.pushNamed(context, '/home/funcionario')),
    ];

    return listaWidget;
  }

  _loadingSolicitacoes(ListarFeriasState state) {
    if (state.status == ListaFeriasStatus.initial || state.status == ListaFeriasStatus.loading && state.ferias.isEmpty) {
      return const Loading(
        texto: 'Aguarde, carregando dados...',
      );
    } else if (state.status == ListaFeriasStatus.refresh) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.status == ListaFeriasStatus.loaded && state.ferias.isNotEmpty) {
      if (state.carregando) {
        state.copyWith(carregando: false);
      }
    } else if (state.ferias.isNotEmpty && state.status == ListaFeriasStatus.initial) {
      return SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/data_empty.gif',
                scale: 2.0,
              ),
              Text(
                'Nenhum Documento Encontrado',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    } else if (state.status == ListaFeriasStatus.error) {
      Dialogs.showSnackBar(context, state.errorMessage ?? '');
    }
    return _listViewFerias(state);
  }

  _listViewFerias(ListarFeriasState state) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state.carregando == true ? state.ferias.length + 1 : state.ferias.length,
            itemBuilder: (context, index) {
              if (state.ferias.length == index) {
                if (state.carregando == true && state.continuarCarregando) {
                  return const Loading();
                } else {
                  Container();
                }
              }

              solFerias = state.ferias[index % state.ferias.length];

              return _cardFerias(solFerias);
            },
          ),
        ),
      ],
    );
  }

  Widget _cardFerias(SolicitacaoFeriasDto solFerias) {
    return Card(
      elevation: 2.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Ink(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.white, corEquipe(solFerias.funcionario?.idEquipe)],
            center: Alignment.centerLeft,
            radius: 12.0,
          ),
        ),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  solFerias.funcionario!.nome.toString(),
                  style: const TextStyle(
                    color: Color(0xFF3F3F3F),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Dept.: ',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3F3F3F),
                        ),
                      ),
                      TextSpan(
                        text: nomeEquipe(
                          solFerias.funcionario?.idEquipe,
                        ),
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF3F3F3F),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Início: ',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3F3F3F),
                            ),
                          ),
                          TextSpan(
                            text: solFerias.ferias!.inicio,
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFF3F3F3F),
                            ),
                          )
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Fim: ',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3F3F3F),
                            ),
                          ),
                          TextSpan(
                            text: solFerias.ferias!.fim,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _botaoNovaSolicitacao() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromHeight(55.0),
        foregroundColor: const Color(0xFFF7A94F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
      icon: const Icon(
        Icons.post_add_outlined,
        color: Colors.white,
        size: 30.0,
      ),
      label: const Text(
        'Nova Solicitação',
        style: TextStyle(fontSize: 22.0, color: Colors.white),
      ),
      onPressed: () => ModalSheetSolicitacao.showModalSheetSolicitacao('/home'),
    );
  }

  nomeEquipe(int? id) {
    Equipe equipe = equipeController.state.equipes.isNotEmpty ? equipeController.state.equipes.firstWhere((e) => e.id == id) : const Equipe();

    return equipe.nome;
  }

  corEquipe(int? id) {
    var equipe = equipeController.state.equipes.isNotEmpty ? equipeController.state.equipes.firstWhere((e) => e.id == id) : null;

    return equipe != null ? Color(int.parse('0xff${equipe.cor?.replaceAll('#', '')}')).withOpacity(.8) : Colors.white;
  }
}
