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
    if (accountType == 'normal') {
      return const SizedBox.shrink();
    }

    return Image.asset(
      _getBadgeImage(),
      width: size,
      height: size,
    );
  }

  String _getBadgeImage() {
    switch (accountType) {
      case 'verified':
        return 'assets/images/TISM-heart-blue.png';
      case 'bot':
        return 'assets/images/TISM-heart-gray.png';
      default:
        return 'assets/images/TISM-heart.png';
    }
  }
}