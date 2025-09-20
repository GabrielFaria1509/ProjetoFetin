import 'package:flutter/material.dart';

class AccountBadge extends StatelessWidget {
  final String accountType;
  final double size;

  const AccountBadge({
    super.key,
    required this.accountType,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    // Só mostra badge para verified e bot
    if (accountType != 'verified' && accountType != 'bot') {
      return const SizedBox.shrink();
    }

    return Image.asset(
      _getBadgeImage(),
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }

  String _getBadgeImage() {
    switch (accountType) {
      case 'verified':
        return 'assets/images/TISM-heart-blue.png';  // Coração azul
      case 'bot':
        return 'assets/images/TISM-heart-gray.png';  // Coração cinza
      default:
        return 'assets/images/TISM-heart.png';       // Fallback
    }
  }
}