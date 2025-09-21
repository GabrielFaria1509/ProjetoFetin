import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/views/home/home_page.dart';
import 'package:tism/services/auth_integration_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  final Map<String, dynamic> userData;
  
  const EmailVerificationScreen({
    super.key, 
    required this.email,
    required this.userData,
  });

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  Timer? _timer;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    _startVerificationCheck();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startVerificationCheck() {
    // Verifica a cada 3 segundos se o usuário foi verificado
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _checkVerificationStatus();
    });
  }

  Future<void> _checkVerificationStatus() async {
    if (_isChecking) return;
    
    setState(() {
      _isChecking = true;
    });

    try {
      // Verificar se email foi verificado
      final response = await http.post(
        Uri.parse('https://tism-backend-api-rgxd.onrender.com/check_verification'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': widget.email,
          'password': widget.userData['password']
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['verified'] == true) {
          _timer?.cancel();
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomePage(nomeUsuario: data['user']['name']),
              ),
            );
          }
        }
      }
    } catch (e) {
      // Continua verificando
    }

    setState(() {
      _isChecking = false;
    });
  }

  Future<void> _resendVerification() async {
    // Reenviar email de verificação
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email de verificação reenviado!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark 
        ? const Color(0xFF121212) 
        : const Color(0xFFE6F2FF),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícone de email
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: tismAqua.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.email_outlined,
                  size: 80,
                  color: tismAqua,
                ),
              ),
              
              const SizedBox(height: 32),
              
              Text(
                'Verifique seu email',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.white 
                    : tismAqua,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              Text(
                'Enviamos um link de verificação para:',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.grey[300] 
                    : Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 8),
              
              Text(
                widget.email,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: tismAqua,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 24),
              
              Text(
                'Clique no link do email para ativar sua conta.\nVocê será redirecionado automaticamente.',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.grey[400] 
                    : Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 32),
              
              if (_isChecking)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(tismAqua),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Verificando...',
                      style: TextStyle(
                        color: tismAqua,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              
              const SizedBox(height: 32),
              
              TextButton(
                onPressed: _resendVerification,
                child: Text(
                  'Reenviar email de verificação',
                  style: TextStyle(
                    color: tismAqua,
                    fontSize: 16,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Voltar ao login',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
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