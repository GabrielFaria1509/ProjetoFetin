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
      // Verificar se o asset existe
      final bytes = await rootBundle.load(widget.assetPath);
      final dir = await getTemporaryDirectory();
      
      // Criar nome de arquivo seguro
      final fileName = widget.title.replaceAll(RegExp(r'[^\w\s-]'), '').replaceAll(' ', '_');
      final file = File('${dir.path}/${fileName}_${DateTime.now().millisecondsSinceEpoch}.pdf');
      
      // Escrever bytes no arquivo
      await file.writeAsBytes(bytes.buffer.asUint8List());
      
      // Verificar se o arquivo foi criado corretamente
      if (await file.exists() && await file.length() > 0) {
        if (mounted) {
          setState(() {
            localPath = file.path;
            isLoading = false;
          });
        }
      } else {
        throw Exception('Arquivo PDF não foi criado corretamente');
      }
    } catch (e) {
      print('Erro ao carregar PDF: $e');
      print('Asset path: ${widget.assetPath}');
      
      if (mounted) {
        setState(() {
          errorMessage = 'Erro ao carregar PDF: ${widget.title}\n\nVerifique se o arquivo existe em: ${widget.assetPath}';
          isLoading = false;
        });
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
        actions: [
          if (totalPages > 0)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  '${currentPage + 1}/$totalPages',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Carregando PDF...'),
                ],
              ),
            )
          : errorMessage != null
              ? _buildErrorView()
              : _buildPDFView(),
      bottomNavigationBar: localPath != null && totalPages > 1
          ? Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark 
                  ? const Color(0xFF1E1E1E) 
                  : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
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
    if (localPath == null || !File(localPath!).existsSync()) {
      return _buildErrorView();
    }
    
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
        if (mounted) {
          setState(() {
            totalPages = pages ?? 0;
          });
        }
      },
      onViewCreated: (PDFViewController controller) {
        pdfController = controller;
      },
      onPageChanged: (int? page, int? total) {
        if (mounted) {
          setState(() {
            currentPage = page ?? 0;
          });
        }
      },
      onError: (error) {
        print('PDF Error: $error');
        if (mounted) {
          setState(() {
            errorMessage = 'Erro na visualização do PDF: $error';
          });
        }
      },
      onPageError: (page, error) {
        print('PDF Page Error: $page - $error');
        if (mounted) {
          setState(() {
            errorMessage = 'Erro na página $page: $error';
          });
        }
      },
    );
  }
}