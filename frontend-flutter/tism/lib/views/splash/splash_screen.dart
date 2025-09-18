import 'package:flutter/material.dart';
import 'package:tism/views/login/login_startup.dart';
import 'package:tism/views/home/home_page.dart';
import 'package:tism/services/auth_integration_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeInController;
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    
    _fadeInController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeInController,
      curve: Curves.easeIn,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.25, 1.0, curve: Curves.easeInExpo),
    ));

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.67, 1.0, curve: Curves.easeOut),
    ));

    _startAnimation();
  }

  void _startAnimation() async {
    try {
      // Fade in do logo (0.3s)
      await _fadeInController.forward();
      
      // Aguarda mais um tempo mostrando o logo
      await Future.delayed(const Duration(milliseconds: 1000));
      
      // Inicia a animação de saída
      await _animationController.forward();
      
      _navigateToNextScreen();
    } catch (e) {
      // Em caso de erro, navega para login
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginStartup()),
        );
      }
    }
  }

  void _navigateToNextScreen() async {
    if (!mounted) return;
    
    try {
      final isLoggedIn = await AuthIntegrationService.isLoggedIn()
          .timeout(const Duration(seconds: 3));
      if (!mounted) return;
      
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomePage(nomeUsuario: 'Usuário'),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginStartup()),
        );
      }
    } catch (e) {
      // Em caso de erro, vai para login
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginStartup()),
        );
      }
    }
  }

  @override
  void dispose() {
    _fadeInController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([_fadeInController, _animationController]),
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 - _scaleAnimation.value,
              child: Opacity(
                opacity: _fadeInAnimation.value * (1.0 - _opacityAnimation.value),
                child: Image.asset(
                  'assets/images/TISM-heart.png',
                  width: 200,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) => 
                    const Icon(Icons.favorite, size: 200, color: Colors.blue),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}