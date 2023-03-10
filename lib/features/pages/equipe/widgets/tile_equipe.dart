import 'package:flutter/material.dart';

import 'package:app/features/pages/shared/rich_text_widget.dart';

class TileEquipe extends StatelessWidget {
  final String? nomeEquipe;
  final int? idEquipe;
  final String? cor;

  const TileEquipe({
    Key? key,
    this.nomeEquipe,
    this.idEquipe,
    this.cor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 3.0,
      child: Ink(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.white, Color(int.parse('0xFF${cor!.replaceAll('#', '')}')).withOpacity(.8)],
            center: Alignment.centerLeft,
            radius: 12.0,
          ),
        ),
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, '/home/equipe/funcionarios', arguments: {'nomeEquipe': nomeEquipe, 'idEquipe': idEquipe}),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichTextWidget(
                  label: nomeEquipe ?? 'Sem Nome',
                  labeltextStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF3F3F3F),
                    fontWeight: FontWeight.bold,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF3F3F3F),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
