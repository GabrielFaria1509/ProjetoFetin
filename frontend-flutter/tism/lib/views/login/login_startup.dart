import 'package:flutter/material.dart';
import 'dart:async';
import 'login_page.dart'; // Certifique-se de que este arquivo existe

class LoginStartup extends StatefulWidget {
  const LoginStartup({super.key});

  @override
  State<LoginStartup> createState() => _LoginStartupState();
}

class _LoginStartupState extends State<LoginStartup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    // Aguarda 1.5s, faz fade out e navega para login_page
    Timer(const Duration(milliseconds: 1500), () async {
      await _controller.forward();
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: Tween<double>(begin: 1, end: 0).animate(_animation),
          child: Image.asset(
            'assets/images/TISM-logo.png', // Coloque o logo nesta pasta
            width: 180,
            height: 180,
          ),
        ),
      ),
    );
  }
}