import 'package:app/features/pages/funcionario/widgets/list_view_funcionario.dart';
import 'package:app/features/pages/shared/dferias_appbar.dart';
import 'package:app/index.dart';
import 'package:flutter/material.dart';

class FuncionarioPage extends StatefulWidget {
  const FuncionarioPage({super.key});

  @override
  State<FuncionarioPage> createState() => _FuncionarioPageState();
}

class _FuncionarioPageState extends State<FuncionarioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DFeriasAppbar(title: 'Funcionarios'),
      body: const ListViewFuncionario(lista: [
        Funcionario(nome: 'Recursos Humanos'),
        Funcionario(nome: 'Renê Henrique Winck Pereira'),
        Funcionario(nome: 'Andre Voronhuk'),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.person_add_outlined,
          color: Colors.white,
        ),
        onPressed: () => ModalSheetCadastroFuncionario.showModalSheetCadastroFuncionario(),
      ),
    );
  }
}
