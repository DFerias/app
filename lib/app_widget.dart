import 'package:app/index.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D-Férias',
      navigatorKey: App.navigator,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
          scaffoldBackgroundColor: const Color(0xFFF7EADC),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFE5DACC),
            primary: const Color(0xFFFF8D06),
            secondary: const Color(0xFFF19413),
            outline: Colors.grey[500],
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF8D06), foregroundColor: Colors.white))),
      initialRoute: App.authService.logado ? '/home' : '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        // '/cadastrarFuncionario': (context) => CadastroFuncionarioRoutes.page,
      },
    );
  }
}
