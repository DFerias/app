import 'package:app/features/domain/entities/funcionario.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListViewFuncionarioEquipe extends StatelessWidget {
  final List<Funcionario> funcionarios;

  const ListViewFuncionarioEquipe({super.key, required this.funcionarios});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 10.0),
      itemCount: funcionarios.length,
      itemBuilder: (context, index) {
        return ListTile(
          minLeadingWidth: 5.0,
          leading: const Icon(Icons.account_circle, size: 50.0),
          title: Text(
            funcionarios[index].nome!,
            style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 3.0),
              Text('Admissão: ${formatarData(funcionarios[index].dataAdmissao!)}'),
              const SizedBox(height: 3.0),
              Text('Saldo de Férias: ${funcionarios[index].saldoFerias}'),
            ],
          ),
        );
      },
    );
  }

  formatarData(DateTime data) {
    return DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(data.toString()));
  }
}
