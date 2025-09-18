import 'package:flutter/material.dart';
import 'dart:io';
import '../services/firebase_auth_service.dart';
import '../constants/colors.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback onGoogleLogin;
  final VoidCallback onAppleLogin;
  final VoidCallback? onLoading;

  const SocialLoginButtons({
    super.key,
    required this.onGoogleLogin,
    required this.onAppleLogin,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Botão Google
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: onGoogleLogin,
            icon: Image.asset(
              'assets/images/google_logo.png',
              height: 24,
              width: 24,
              errorBuilder: (context, error, stackTrace) => 
                const Icon(Icons.g_mobiledata, size: 24),
            ),
            label: const Text('Continuar com Google'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              side: BorderSide(color: Colors.grey[300]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Botão Apple (apenas iOS)
        if (Platform.isIOS)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: onAppleLogin,
              icon: const Icon(Icons.apple, size: 24, color: Colors.white),
              label: const Text('Continuar com Apple'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
      ],
    );
  }


}