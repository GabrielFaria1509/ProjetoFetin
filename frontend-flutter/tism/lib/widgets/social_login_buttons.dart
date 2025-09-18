import 'package:flutter/material.dart';
import 'dart:io';

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
      mainAxisSize: MainAxisSize.min,
      children: [
        // Botão Google
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: onGoogleLogin,
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              side: BorderSide(color: Colors.grey[300]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.g_mobiledata, size: 24, color: Colors.red),
                const SizedBox(width: 8),
                const Text('Continuar com Google'),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Botão Apple (apenas iOS)
        if (Platform.isIOS)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: onAppleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.apple, size: 24, color: Colors.white),
                  const SizedBox(width: 8),
                  const Text('Continuar com Apple'),
                ],
              ),
            ),
          ),
      ],
    );
  }
}