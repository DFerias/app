import 'package:app/features/pages/equipe/equipe_page.dart';
import 'package:app/features/pages/routes/funcionario_equipe_routes.dart';
import 'package:app/features/pages/routes/funcionario_routes.dart';
import 'package:app/features/pages/routes/historico_routes.dart';
import 'package:app/features/pages/routes/solicitacao_routes.dart';
import 'package:app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D-Férias',
      navigatorKey: App.navigator,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'mplus1',
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
        '/home/historico': (context) => HistoricoRoutes.page,
        '/home/solicitacao': (context) => SolicitacaoRoutes.page,
        '/home/equipe': (context) => const EquipePage(),
        '/home/equipe/funcionarios': (context) => FuncionarioEquipeRoutes.page,
        '/home/funcionario': (context) => FuncionarioRoutes.page,
      },
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
