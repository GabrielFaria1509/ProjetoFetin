import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'dart:html' as html;

class PDFViewerImpl extends StatelessWidget {
  final String title;
  final String assetPath;

  const PDFViewerImpl({super.key, required this.title, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.picture_as_pdf, size: 64, color: Colors.blue),
          const SizedBox(height: 16),
          Text(
            'Visualizar PDF: $title',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              html.window.open(assetPath, '_blank');
            },
            icon: const Icon(Icons.open_in_new),
            label: const Text('Abrir PDF'),
            style: ElevatedButton.styleFrom(
              backgroundColor: tismAqua,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}