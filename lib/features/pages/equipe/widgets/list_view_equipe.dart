import 'dart:developer';

import 'package:app/features/domain/entities/funcionario.dart';
import 'package:flutter/material.dart';

import 'package:app/features/domain/entities/equipe.dart';
import 'package:app/features/pages/equipe/widgets/tile_equipe.dart';
import 'package:app/features/pages/funcionario/cubit/lista_funcionario_cubit/funcionario_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListViewEquipe extends StatefulWidget {
  final List<Equipe> lista;
  final FuncionarioController funcionarioController;

  const ListViewEquipe({
    Key? key,
    required this.lista,
    required this.funcionarioController,
  }) : super(key: key);

  @override
  State<ListViewEquipe> createState() => _ListViewEquipeState();
}

class _ListViewEquipeState extends State<ListViewEquipe> {
  @override
  void initState() {
    super.initState();

    widget.funcionarioController.getFuncionarios();
    inspect(widget.funcionarioController.state.funcionarios);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FuncionarioController, FuncionarioState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: widget.lista.length,
          itemBuilder: (context, index) {
            getLiderEquipe() {
              if (widget.funcionarioController.state.funcionarios.isNotEmpty) {
                Funcionario func = widget.funcionarioController.state.funcionarios.firstWhere((Funcionario e) => e.id == widget.lista[index].idLider);

                return func.nome;
              }
            }

            return TileEquipe(
              nomeEquipe: widget.lista[index].nome ?? '',
              idEquipe: widget.lista[index].id ?? 0,
              nomeLider: getLiderEquipe(),
              cor: widget.lista[index].cor ?? '',
            );
          },
        );
      },
    );
  }
}
