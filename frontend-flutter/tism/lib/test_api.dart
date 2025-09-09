import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TestApiScreen extends StatefulWidget {
  const TestApiScreen({super.key});

  @override
  State<TestApiScreen> createState() => _TestApiScreenState();
}

class _TestApiScreenState extends State<TestApiScreen> {
  String _result = 'Clique no botão para testar a API';
  bool _isLoading = false;

  Future<void> _testAPI() async {
    setState(() {
      _isLoading = true;
      _result = 'Testando API...';
    });

    try {
      await dotenv.load();
      final apiKey = dotenv.env['GEMINI_API_KEY'];
      
      if (apiKey == null || apiKey.isEmpty) {
        setState(() {
          _result = 'ERRO: API key não encontrada no arquivo .env';
          _isLoading = false;
        });
        return;
      }
      
      setState(() {
        _result = 'API Key encontrada!\nTestando conexão...';
      });

      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );

      final content = [Content.text('Olá, você está funcionando? Responda em português.')];
      final response = await model.generateContent(content);

      setState(() {
        _result = 'SUCESSO!\n\nResposta da API:\n${response.text}';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _result = 'ERRO:\n$e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste API Gemini'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _testAPI,
              child: _isLoading 
                ? const CircularProgressIndicator()
                : const Text('Testar API Gemini'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _result,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}