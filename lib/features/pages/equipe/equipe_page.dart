import 'package:app/core/ui/base_state/base_state.dart';
import 'package:app/features/pages/equipe/equipe_controller/equipe_controller.dart';
import 'package:app/features/pages/equipe/widgets/list_view_equipe.dart';
import 'package:app/features/pages/shared/dferias_appbar.dart';
import 'package:app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EquipePage extends StatefulWidget {
  const EquipePage({super.key});

  @override
  State<EquipePage> createState() => _EquipePageState();
}

class _EquipePageState extends BaseState<EquipePage, EquipeController> {
  @override
  void onReady() {
    super.onReady();

    controller.getEquipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DFeriasAppbar(
        title: 'Equipes',
      ),
      body: BlocBuilder<EquipeController, EquipeState>(
        builder: (context, state) {
          return ListViewEquipe(lista: controller.state.equipes);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          ModalSheetCadastroEquipe.showModalSheetCadastroEquipe(/* '/home/equipe' */).then((value) async {
            if (value == true) {
              await controller.getEquipes();
            }
          });
        },
        child: const Icon(
          Icons.group_add_outlined,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );
  }
}
