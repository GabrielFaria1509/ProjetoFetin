import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:tism/constants/colors.dart';

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
  String? errorMessage;
  int currentPage = 0;
  int totalPages = 0;
  PDFViewController? pdfController;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    try {
      final bytes = await rootBundle.load(widget.assetPath);
<<<<<<< HEAD
      final dir = await getApplicationDocumentsDirectory();
      
      final fileName = widget.title
          .replaceAll(RegExp(r'[^\w\s-]'), '')
          .replaceAll(' ', '_');
      
=======
      final dir = await getTemporaryDirectory();
      final fileName = widget.title.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
>>>>>>> a9e4406608c2423bae344a6c69d69b80fe31f3de
      final file = File('${dir.path}/$fileName.pdf');
      await file.writeAsBytes(bytes.buffer.asUint8List());
      
<<<<<<< HEAD
=======
      await file.writeAsBytes(bytes.buffer.asUint8List());
      
>>>>>>> a9e4406608c2423bae344a6c69d69b80fe31f3de
      if (mounted) {
        setState(() {
          localPath = file.path;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = 'Erro ao carregar PDF: ${e.toString()}';
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: tismAqua,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
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
                          _loadPDF();
                        },
                        child: const Text('Tentar Novamente'),
                      ),
                    ],
                  ),
<<<<<<< HEAD
                )
              : PDFView(
                  filePath: localPath!,
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: false,
                  pageFling: true,
                  onRender: (pages) {
                    setState(() {
                      totalPages = pages ?? 0;
                    });
                  },
                  onViewCreated: (PDFViewController controller) {
                    pdfController = controller;
                  },
                  onPageChanged: (int? page, int? total) {
                    setState(() {
                      currentPage = page ?? 0;
                    });
                  },
                ),
=======
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: currentPage > 0
                        ? () => pdfController?.setPage(currentPage - 1)
                        : null,
                    icon: Icon(
                      Icons.chevron_left,
                      color: Theme.of(context).brightness == Brightness.dark 
                        ? Colors.white 
                        : null,
                    ),
                  ),
                  Text(
                    'Página ${currentPage + 1} de $totalPages',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).brightness == Brightness.dark 
                        ? Colors.white 
                        : null,
                    ),
                  ),
                  IconButton(
                    onPressed: currentPage < totalPages - 1
                        ? () => pdfController?.setPage(currentPage + 1)
                        : null,
                    icon: Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).brightness == Brightness.dark 
                        ? Colors.white 
                        : null,
                    ),
                  ),
                ],
              ),
            )
          : null,
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
                _loadPDF();
              },
              child: const Text('Tentar Novamente'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPDFView() {
    return PDFView(
      filePath: localPath!,
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: false,
      pageFling: true,
      pageSnap: true,
      defaultPage: currentPage,
      fitPolicy: FitPolicy.BOTH,
      preventLinkNavigation: false,
      onRender: (pages) {
        setState(() {
          totalPages = pages ?? 0;
        });
      },
      onViewCreated: (PDFViewController controller) {
        pdfController = controller;
      },
      onPageChanged: (int? page, int? total) {
        setState(() {
          currentPage = page ?? 0;
        });
      },
      onError: (error) {
        setState(() {
          errorMessage = 'Erro na visualização: $error';
        });
      },
      onPageError: (page, error) {
        setState(() {
          errorMessage = 'Erro na página $page: $error';
        });
      },
>>>>>>> a9e4406608c2423bae344a6c69d69b80fe31f3de
    );
  }
}