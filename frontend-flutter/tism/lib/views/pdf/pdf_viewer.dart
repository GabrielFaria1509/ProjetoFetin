import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';

// Conditional imports
import 'pdf_viewer_mobile.dart' if (dart.library.html) 'pdf_viewer_web.dart';

class PDFViewer extends StatefulWidget {
  final String title;
  final String assetPath;

  const PDFViewer({super.key, required this.title, required this.assetPath});

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: tismAqua,
        foregroundColor: Colors.white,
      ),
      body: PDFViewerImpl(
        title: widget.title,
        assetPath: widget.assetPath,
      ),
    );
  }
}