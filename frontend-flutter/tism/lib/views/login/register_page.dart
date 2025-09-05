import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/services/user_service.dart';
import 'package:tism/views/home/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();
  String _userType = 'Responsável';
  bool _isLoading = false;
  String? erro;

  Future<void> _registrar() async {
    final nome = nomeController.text.trim();
    final email = emailController.text.trim();
    final senha = senhaController.text;
    final confirmar = confirmarSenhaController.text;

    setState(() => erro = null);

    if (nome.isEmpty || email.isEmpty || senha.isEmpty || confirmar.isEmpty) {
      setState(() => erro = 'Preencha todos os campos.');
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      setState(() => erro = 'Digite um email válido.');
      return;
    }

    if (senha.length < 8) {
      setState(() => erro = 'A senha deve ter pelo menos 8 caracteres.');
      return;
    }

    if (senha != confirmar) {
      setState(() => erro = 'As senhas não coincidem.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await UserService.register(
        username: nome,
        email: email,
        password: senha,
        userType: _userType,
      );

      if (mounted) {
        setState(() => _isLoading = false);

        if (result['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'Cadastro realizado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(nomeUsuario: nome),
            ),
          );
        } else {
          setState(() => erro = result['error']);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          erro = 'Erro de conexão: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F2FF),
      appBar: AppBar(backgroundColor: tismAqua, title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome de usuário',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha (mínimo 8 caracteres)',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmarSenhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _userType,
                decoration: InputDecoration(
                  labelText: 'Tipo de usuário',
                  prefixIcon: const Icon(Icons.work),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: 'Responsável', child: Text('Responsável')),
                  DropdownMenuItem(value: 'Professor', child: Text('Professor')),
                ],
                onChanged: (value) {
                  setState(() => _userType = value!);
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tismAqua,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isLoading ? null : _registrar,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Cadastrar',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
              if (erro != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Text(
                      erro!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
