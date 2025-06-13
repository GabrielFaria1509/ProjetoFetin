import 'package:flutter/material.dart';
import 'views/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // <-- Corrigido o nome da classe
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const LoginPage(), // <-- Agora começa na tela de login
    );
  }
}
