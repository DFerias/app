import 'package:app/core/ui/base_state/base_state.dart';
import 'package:app/features/pages/equipe/equipe_controller/equipe_controller.dart';
import 'package:app/features/pages/shared/dferias_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EquipePage extends StatefulWidget {
  const EquipePage({super.key});

  @override
  State<EquipePage> createState() => _EquipePageState();
}

class _EquipePageState extends BaseState<EquipePage, EquipeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DFeriasAppbar(
        title: 'Equipes',
      ),
      body: BlocBuilder<EquipeController, EquipeState>(
        builder: (context, state) {
          return Container();
        },
      ),
    );
  }
}
