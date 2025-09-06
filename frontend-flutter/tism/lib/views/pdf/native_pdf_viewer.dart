import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:tism/constants/colors.dart';

class NativePDFViewer extends StatefulWidget {
  final String title;
  final String assetPath;

  const NativePDFViewer({super.key, required this.title, required this.assetPath});

  @override
  State<NativePDFViewer> createState() => _NativePDFViewerState();
}

class _NativePDFViewerState extends State<NativePDFViewer> {
  bool isLoading = true;
  String? errorMessage;
  String? filePath;

  @override
  void initState() {
    super.initState();
    _prepareFile();
  }

  Future<void> _prepareFile() async {
    try {
      final bytes = await rootBundle.load(widget.assetPath);
      final dir = await getApplicationDocumentsDirectory();
      
      final fileName = widget.title
          .replaceAll(RegExp(r'[^\w\s-]'), '')
          .replaceAll(' ', '_');
      
      final file = File('${dir.path}/$fileName.pdf');
      await file.writeAsBytes(bytes.buffer.asUint8List());
      
      if (await file.exists()) {
        setState(() {
          filePath = file.path;
          isLoading = false;
        });
      } else {
        throw Exception('Arquivo não foi criado');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Erro ao preparar arquivo: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _openWithNativeApp() async {
    if (filePath == null) return;
    
    try {
      final uri = Uri.file(filePath!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw Exception('Nenhum aplicativo disponível para abrir PDF');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao abrir PDF: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontSize: 16)),
        backgroundColor: tismAqua,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Preparando PDF...'),
                ],
              ),
            )
          : errorMessage != null
              ? _buildErrorView()
              : _buildSuccessView(),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Erro ao carregar PDF',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                  errorMessage = null;
                });
                _prepareFile();
              },
              child: const Text('Tentar Novamente'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.picture_as_pdf, size: 80, color: tismAqua),
            const SizedBox(height: 24),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'PDF preparado com sucesso!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _openWithNativeApp,
              icon: const Icon(Icons.open_in_new),
              label: const Text('Abrir com Aplicativo Externo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: tismAqua,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'O PDF será aberto no seu aplicativo de PDF padrão',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}