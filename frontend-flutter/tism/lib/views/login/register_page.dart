import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';

class RegisterPage extends StatefulWidget {
  final Function(String nome, String senha) onRegister;

  const RegisterPage({super.key, required this.onRegister});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController =
      TextEditingController();
  String? erro;

  void _registrar() {
    final nome = nomeController.text.trim();
    final senha = senhaController.text;
    final confirmar = confirmarSenhaController.text;

    if (nome.isEmpty || senha.isEmpty || confirmar.isEmpty) {
      setState(() => erro = 'Preencha todos os campos.');
      return;
    }

    if (senha != confirmar) {
      setState(() => erro = 'As senhas não coincidem.');
      return;
    }

    widget.onRegister(nome, senha);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F2FF),
      appBar: AppBar(backgroundColor: tismAqua, title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome de usuário'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmarSenhaController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirmar Senha'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: tismAqua),
              onPressed: _registrar,
              child: const Text('Cadastrar'),
            ),
            if (erro != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(erro!, style: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}
