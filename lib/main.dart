import 'package:app/app_widget.dart';
import 'package:app/core/injections/injection.dart';

import 'package:app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Injection().init();

  await App.instance.inicializar();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => CadastrarFuncionarioController(GetIt.instance(), GetIt.instance())),
        BlocProvider(create: (context) => ListarFeriasController(GetIt.instance())),
      ],
      child: const AppWidget(),
    );
  }
}
