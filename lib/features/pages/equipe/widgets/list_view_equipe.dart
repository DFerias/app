import 'package:app/features/domain/entities/equipe.dart';
import 'package:app/features/pages/equipe/widgets/tile_equipe.dart';
import 'package:flutter/material.dart';

class ListViewEquipe extends StatelessWidget {
  final List<Equipe> lista;

  const ListViewEquipe({
    Key? key,
    required this.lista,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) {
        return TileEquipe(
          nomeEquipe: lista[index].nome ?? '',
          idEquipe: lista[index].id ?? 0,
          cor: lista[index].cor ?? '',
        );
      },
    );
  }
}
