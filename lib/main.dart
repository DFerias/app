import 'package:app/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D-Férias',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7EADC),
        colorScheme: const ColorScheme.light(primary: Color(0xFFFF8D06), secondary: Color(0xFFF19413)),
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
