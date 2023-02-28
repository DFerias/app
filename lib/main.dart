import 'package:app/app_widget.dart';
import 'package:app/core/injections/injection.dart' as di;
import 'package:app/features/pages/equipe/equipe_controller/equipe_controller.dart';

import 'package:app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await App.instance.inicializar();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthController()),
        BlocProvider(create: (context) => ListarFeriasController()),
        BlocProvider(create: (context) => EquipeController()),
      ],
      child: const AppWidget(),
    );
  }
}
