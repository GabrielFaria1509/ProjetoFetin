import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/l10n/app_localizations.dart';
import 'package:web/web.dart' as web;

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
            '${AppLocalizations.of(context)!.app_name} PDF: $title',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              web.window.open(assetPath, '_blank');
            },
            icon: const Icon(Icons.open_in_new),
            label: Text(AppLocalizations.of(context)!.app_name),
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