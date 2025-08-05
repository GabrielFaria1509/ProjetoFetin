import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'chatbot_service.dart';
import 'quick_suggestions.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  static const int _maxMessages = 50; // Limite para economizar RAM

  @override
  void initState() {
    super.initState();
    // Mensagem de boas-vindas otimizada
    _messages.add(ChatMessage(
      text: '👋 **Olá! Sou especialista em TEA**\n\n🎯 **Posso ajudar com:**\n• Identificar sintomas\n• Diagnóstico e profissionais\n• Terapias (ABA, fono, TO)\n• Inclusão escolar\n• Apoio à família\n• Direitos e benefícios\n\n💡 **Exemplos:** "Como identificar autismo?" ou "Meu filho tem 3 anos e não fala"',
      isUser: false,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistente TEA'),
        backgroundColor: tismAqua,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return ChatBubble(message: message);
              },
            ),
          ),
          if (_isLoading)
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(tismAqua),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('Pensando...', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          if (_messages.length <= 1) // Mostra sugestões apenas no início
            QuickSuggestions(onSuggestionTap: _sendMessage),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 1)],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'Ex: "Meu filho não fala, pode ser autismo?"',
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 13),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: tismAqua),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                onSubmitted: _isLoading ? null : _sendMessage,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: _isLoading ? Colors.grey[300] : tismAqua,
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                onPressed: _isLoading ? null : () => _sendMessage(_controller.text),
                icon: const Icon(Icons.send, color: Colors.white, size: 20),
                padding: const EdgeInsets.all(8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Limita histórico para economizar memória
    if (_messages.length >= _maxMessages) {
      _messages.removeRange(0, _messages.length - _maxMessages + 2);
    }

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isLoading = true;
    });

    _controller.clear();
    _scrollToBottom();

    final response = await ChatbotService.sendMessage(text);

    setState(() {
      _messages.add(ChatMessage(text: response, isUser: false));
      _isLoading = false;
    });
    
    _scrollToBottom();
  }
  
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
  
  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('💙 Sobre o Assistente TEA'),
        content: const Text(
          'Sou especializado em Transtorno do Espectro Autista (TEA).\n\n'
          '🎯 Posso ajudar pais e professores com:\n'
          '• Identificação de sintomas\n'
          '• Orientações sobre diagnóstico\n'
          '• Informações sobre terapias\n'
          '• Dicas para inclusão escolar\n'
          '• Direitos e benefícios\n\n'
          '⚠️ Importante: Não substituo consulta médica!'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendi'),
          ),
        ],
      ),
    );
  }
}

// Classe otimizada para economizar memória
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime? timestamp; // Opcional para economizar memória

  ChatMessage({
    required this.text, 
    required this.isUser,
    this.timestamp,
  });
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) 
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: CircleAvatar(
                radius: 14,
                backgroundColor: tismAqua,
                child: const Icon(Icons.psychology, size: 16, color: Colors.white),
              ),
            ),
          const SizedBox(width: 6),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: message.isUser ? tismAqua : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: message.isUser ? null : Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : Colors.black87,
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          if (message.isUser) 
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.grey[400],
                child: const Icon(Icons.person, size: 16, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}