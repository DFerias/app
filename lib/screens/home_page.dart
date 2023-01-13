import 'package:app/index.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                Row(
                  children: [
                    _circleAvatar(),
                    const SizedBox(width: 10.0),
                    _displayInfoUser(),
                  ],
                ),
                _buttonLogOut(),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
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
          text: const TextSpan(
            children: [
              TextSpan(text: 'Bem-vindo(a), ', style: TextStyle(fontSize: 16.0)),
              TextSpan(text: 'Renê!', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const Text('Desenvolvimento - Bsoft One', style: TextStyle(fontSize: 16.0)),
      ],
    );
  }

  Widget _buttonLogOut() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          child: Row(
            children: const [
              Text(
                'Sair',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5.0),
              Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Icon(Icons.logout_outlined, color: Colors.white),
              ),
            ],
          ),
          onTap: () {
            Dialogs.showLoadingDialog(mensagem: 'Saindo...');
            Future.delayed(
              const Duration(milliseconds: 500),
              () {
                Dialogs.close();
                App.authService.logOut();
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _listIconButtons() {
    return ListView(
      itemExtent: 75.0,
      scrollDirection: Axis.horizontal,
      children: [
        _botaoHistorico(),
        _botaoQuadroFerias(),
        _botaoSolicitacoes(),
        _botaoCadastrarSetor(),
        _botaoCadastrarFuncionario(),
      ],
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
              'Quadro Geral de Férias',
              style: TextStyle(fontSize: 18.0, color: Color(0xFF3F3F3F)),
            ),
            const SizedBox(height: 5.0),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                physics: const PageScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return _cardFerias();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardFerias() {
    return Card(
      elevation: 2.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Ink(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fernando Mendes',
                  style: TextStyle(
                    color: Color(0xFF3F3F3F),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Dept.: ',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3F3F3F),
                        ),
                      ),
                      TextSpan(
                        text: 'Desenvolvimento',
                        style: TextStyle(
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
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Início: ',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3F3F3F),
                            ),
                          ),
                          TextSpan(
                            text: '12/12/2022',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFF3F3F3F),
                            ),
                          )
                        ],
                      ),
                    ),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Fim: ',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3F3F3F),
                            ),
                          ),
                          TextSpan(
                            text: '10/01/2023',
                            style: TextStyle(
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
          onTap: () {},
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
      onPressed: () {},
    );
  }

  Widget _botaoHistorico() {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12.0),
            backgroundColor: const Color(0xFFFE9822),
            foregroundColor: const Color(0xFFF7A94F),
          ),
          child: const Icon(
            Icons.history,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {},
        ),
        const SizedBox(
          height: 8.0,
        ),
        const Text(
          'Histórico',
          style: TextStyle(fontSize: 12.0, color: Colors.black),
        ),
      ],
    );
  }

  Widget _botaoQuadroFerias() {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12.0),
            backgroundColor: const Color(0xFFFE9822),
            foregroundColor: const Color(0xFFF7A94F),
          ),
          child: const Icon(
            Icons.calendar_month_outlined,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {},
        ),
        const SizedBox(
          height: 8.0,
        ),
        const Text(
          'Quadro \nde Férias',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
        ),
      ],
    );
  }

  Widget _botaoSolicitacoes() {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12.0),
            backgroundColor: const Color(0xFFFE9822),
            foregroundColor: const Color(0xFFF7A94F),
          ),
          child: const Icon(
            Icons.checklist_outlined,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {},
        ),
        const SizedBox(
          height: 8.0,
        ),
        const Text(
          'Solicitações',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
        ),
      ],
    );
  }

  Widget _botaoCadastrarSetor() {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12.0),
            backgroundColor: const Color(0xFFFE9822),
            foregroundColor: const Color(0xFFF7A94F),
          ),
          child: const Icon(
            Icons.group_add_outlined,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {},
        ),
        const SizedBox(
          height: 8.0,
        ),
        const Text(
          'Cadastrar \nSetor',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
        ),
      ],
    );
  }

  Widget _botaoCadastrarFuncionario() {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12.0),
            backgroundColor: const Color(0xFFFE9822),
            foregroundColor: const Color(0xFFF7A94F),
          ),
          child: const Icon(
            Icons.person_add_outlined,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {},
        ),
        const SizedBox(
          height: 8.0,
        ),
        const Text(
          'Cadastrar \nFuncionário',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
        ),
      ],
    );
  }
}
