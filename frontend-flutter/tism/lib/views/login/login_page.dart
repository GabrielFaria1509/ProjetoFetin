import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/views/home/home_page.dart';
import 'package:tism/views/login/register_page.dart';
import 'package:tism/services/auth_integration_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  bool _isLoading = false;



  Future<void> _tentarLogin() async {
    final email = emailController.text.trim();
    final senha = senhaController.text;

    if (email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite um email válido'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (senha.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A senha deve ter pelo menos 8 caracteres'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await AuthIntegrationService.loginWithEmail(email, senha);

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        if (result['success']) {
          final user = result['user'];
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomePage(nomeUsuario: user['name']),
              ),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result['error'] ?? 'Erro no login'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro de conexão: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark 
        ? const Color(0xFF121212) 
        : const Color(0xFFE6F2FF),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Theme.of(context).brightness == Brightness.dark 
                  ? 'assets/images/TISM-logo-dark.png'
                  : 'assets/images/TISM-logo.png',
                height: 80,
              ),
              const SizedBox(height: 24),
              Text(
                'Olá, seja bem vindo(a)!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.white 
                    : tismAqua,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark 
                        ? Colors.grey[600]! 
                        : Colors.black
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: tismAqua, width: 2),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark 
                    ? const Color(0xFF2A2A2A) 
                    : Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: const Icon(Icons.lock),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark 
                        ? Colors.grey[600]! 
                        : Colors.black
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: tismAqua, width: 2),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark 
                    ? const Color(0xFF2A2A2A) 
                    : Colors.white,
                ),
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
                  onPressed: _isLoading ? null : _tentarLogin,
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
                          'Entrar',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  );
                },
                child: const Text('Ainda não tem conta ? Cadastre-se'),
              ),
              const SizedBox(height: 16),
              Text(
                'Tudo o que você precisa saber sobre o TEA em um clique 💙',
                style: TextStyle(
                  fontSize: 12, 
                  color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.grey[400] 
                    : Colors.black54
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
