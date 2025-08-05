import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tism/constants/colors.dart';
import 'dart:io';

class PDFViewer extends StatefulWidget {
  final String title;
  final String assetPath;

  const PDFViewer({super.key, required this.title, required this.assetPath});

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  String? localPath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    try {
      final bytes = await rootBundle.load(widget.assetPath);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/${widget.title}.pdf');
      await file.writeAsBytes(bytes.buffer.asUint8List());
      
      setState(() {
        localPath = file.path;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: tismAqua,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : localPath != null
              ? PDFView(
                  filePath: localPath!,
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: false,
                  pageFling: false,
                )
              : const Center(
                  child: Text('Erro ao carregar PDF'),
                ),
    );
  }
}