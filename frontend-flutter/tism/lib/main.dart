import 'package:flutter/material.dart';
import 'package:tism/views/login/login_page.dart';
import 'package:tism/views/home/home_page.dart'; // Importe sua HomePage
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TISM App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        // CORREÇÃO AQUI: Passe um valor para 'nomeUsuario'
        '/home': (context) => const HomePage(nomeUsuario: 'Usuário Logado'),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
