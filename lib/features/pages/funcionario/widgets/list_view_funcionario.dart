import 'package:flutter/material.dart';

import 'package:app/features/domain/usecases/usecases.dart';

class ListViewFuncionario extends StatelessWidget {
  final List<Funcionario> lista;

  const ListViewFuncionario({
    Key? key,
    required this.lista,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) {
        return ListTile(
          minLeadingWidth: 5.0,
          leading: const Icon(Icons.account_circle, size: 30.0),
          title: Text(
            lista[index].nome!,
            style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
