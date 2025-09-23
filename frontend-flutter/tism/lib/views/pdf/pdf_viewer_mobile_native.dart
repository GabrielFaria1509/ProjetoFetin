import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class PDFViewerImpl extends StatefulWidget {
  final String title;
  final String assetPath;

  const PDFViewerImpl({super.key, required this.title, required this.assetPath});

  @override
  State<PDFViewerImpl> createState() => _PDFViewerImplState();
}

class _PDFViewerImplState extends State<PDFViewerImpl> {
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _openPDF();
  }

  Future<void> _openPDF() async {
    try {
      final bytes = await rootBundle.load(widget.assetPath);
      final dir = await getTemporaryDirectory();
      
      final fileName = widget.title
          .replaceAll(RegExp(r'[^\w\s-]'), '')
          .replaceAll(' ', '_');
      
      final file = File('${dir.path}/$fileName.pdf');
      await file.writeAsBytes(bytes.buffer.asUint8List());
      
      final uri = Uri.file(file.path);
      
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        throw 'Não foi possível abrir o PDF';
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = 'Erro ao abrir PDF: $e';
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Abrindo PDF...'),
          ],
        ),
      );
    }
    
    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                  errorMessage = null;
                });
                _openPDF();
              },
              child: const Text('Tentar Novamente'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Voltar'),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}