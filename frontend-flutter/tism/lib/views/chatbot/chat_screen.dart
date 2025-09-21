import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tism/constants/colors.dart';
import 'dart:convert';
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
  static const int _maxMessages = 30; // Otimizado para 8GB RAM

  @override
  void initState() {
    super.initState();
    _messages.add(ChatMessage(
      text: 'Olá! Sou Tina, uma assistente virtual especializada em autismo e neurodiversidade do TISM!\n\nEstou aqui para oferecer suporte personalizado e informações baseadas em evidências científicas sobre:\n\n• Desenvolvimento e comportamento\n• Estratégias educacionais inclusivas\n• Técnicas de comunicação e interação social\n• Adaptações ambientais e sensoriais\n• Recursos e ferramentas práticas para o dia a dia\n\nMinha base de conhecimento foi desenvolvida por uma equipe multidisciplinar de especialistas, incluindo neurologistas, psicólogos, terapeutas ocupacionais, fonoaudiólogos e educadores especiais.\n\nÉ importante ressaltar que não realizo diagnósticos ou substituo profissionais de saúde - meu papel é complementar, oferecendo informações confiáveis e suporte prático para famílias, cuidadores e pessoas neurodivergentes.\n\nComo posso ajudar você hoje?',
      isUser: false,
      avatarMood: 'smile',
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
      backgroundColor: Theme.of(context).brightness == Brightness.dark 
        ? const Color(0xFF121212) 
        : null,
      appBar: AppBar(
        title: const Text('Tina - Assistente TEA'),
        backgroundColor: Theme.of(context).brightness == Brightness.dark 
          ? const Color(0xFF1E1E1E) 
          : tismAqua,
        foregroundColor: Colors.white,
        elevation: Theme.of(context).brightness == Brightness.dark ? 0 : 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () => _showInfoDialog(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
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
      ),
    );
  }

  Widget _buildInputArea() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        boxShadow: [BoxShadow(
          color: isDark ? Colors.black26 : Colors.grey.shade200, 
          blurRadius: 1
        )],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: _isLoading ? null : _sendMessage,
                decoration: InputDecoration(
                  hintText: 'Digite sua mensagem...',
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
                  fillColor: isDark ? const Color(0xFF2A2A2A) : Colors.grey[50],
                ),
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
                icon: Icon(
                  Icons.send, 
                  color: _isLoading ? Colors.grey : Colors.white, 
                  size: 20
                ),
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
    
    // Parse JSON response
    String messageText = response;
    String mood = 'smile';
    
    try {
      String jsonStr = response.trim();
      
      // Extrair JSON se houver texto extra
      int jsonStart = jsonStr.indexOf('{');
      int jsonEnd = jsonStr.lastIndexOf('}');
      
      if (jsonStart >= 0 && jsonEnd > jsonStart) {
        jsonStr = jsonStr.substring(jsonStart, jsonEnd + 1);
      }
      
      final jsonResponse = json.decode(jsonStr);
      messageText = jsonResponse['message']?.toString() ?? response;
      mood = jsonResponse['mood']?.toString() ?? 'smile';
      
      const validMoods = ['grimacing', 'smile', 'happy', 'eyebrow', 'sweat', 'wink'];
      if (!validMoods.contains(mood)) mood = 'smile';
      
      
    } catch (e) {
      messageText = response;
      mood = 'smile';
    }

    setState(() {
      _messages.add(ChatMessage(
        text: messageText,
        isUser: false,
        avatarMood: mood,
      ));
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
        title: const Text('💙 Sobre a Tina'),
        content: MarkdownBody(
          data: '🤖 **Olá! Eu sou a Tina!**\n\n'
          'Sou uma assistente virtual especializada em autismo e neurodiversidade, desenvolvida especialmente para o TISM por uma equipe multidisciplinar de especialistas.\n\n'
          '🎯 **Minha especialização:**\n'
          '• 🧠 Desenvolvimento e comportamento\n'
          '• 🏫 Estratégias educacionais inclusivas\n'
          '• 💬 Técnicas de comunicação e interação social\n'
          '• 🌍 Adaptações ambientais e sensoriais\n'
          '• 🛠️ Recursos práticos para o dia a dia\n\n'
          '🔬 **Base científica:** Fui treinada com conhecimento validado por neurologistas, psicólogos, terapeutas ocupacionais, fonoaudiólogos e educadores especiais.\n\n'
          '⚠️ **Importante:** Não realizo diagnósticos nem substituo profissionais de saúde. Meu papel é complementar, oferecendo suporte informativo e prático.\n\n'
          '💙 **Estou aqui para apoiar você com informações confiáveis e empatia!**',
          styleSheet: MarkdownStyleSheet(
            p: const TextStyle(fontSize: 14, height: 1.4),
            strong: TextStyle(fontWeight: FontWeight.bold, color: tismAqua),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendi, Tina! Vamos conversar! 😊'),
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
  final String? avatarMood;
  final DateTime? timestamp;

  ChatMessage({
    required this.text, 
    required this.isUser,
    this.avatarMood,
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
              margin: const EdgeInsets.only(top: 0),
              child: Image.asset(
                message.avatarMood != null 
                  ? 'assets/images/chatbot/chatbot-${message.avatarMood}.png'
                  : 'assets/images/chatbot/chatbot-smile.png',
                width: 60,
                height: 60,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.psychology, size: 60, color: Colors.grey),
              ),
            ),
          const SizedBox(width: 6),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: message.isUser 
                  ? tismAqua 
                  : Theme.of(context).brightness == Brightness.dark 
                    ? Colors.grey[800] 
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: message.isUser 
                  ? null 
                  : Border.all(
                      color: Theme.of(context).brightness == Brightness.dark 
                        ? Colors.grey[600]! 
                        : Colors.grey[300]!
                    ),
              ),
              child: message.isUser 
                ? SelectableText(
                    message.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.3,
                    ),
                  )
                : MarkdownBody(
                    data: message.text,
                    selectable: true,
                    styleSheet: MarkdownStyleSheet(
                      p: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.white 
                          : Colors.black87,
                        fontSize: 15,
                        height: 1.3,
                      ),
                      strong: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.white 
                          : Colors.black87,
                      ),
                      em: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.white70 
                          : Colors.black87,
                      ),
                      listBullet: TextStyle(
                        color: tismAqua,
                        fontSize: 14,
                      ),
                      h1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: tismAqua,
                      ),
                      h2: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: tismAqua,
                      ),
                      h3: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.white 
                          : Colors.black87,
                      ),
                      code: TextStyle(
                        backgroundColor: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.grey[800] 
                          : Colors.grey[200],
                        color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.white 
                          : Colors.black87,
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                      codeblockDecoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.grey[800] 
                          : Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      blockquote: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.grey[400] 
                          : Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
            ),
          ),
          const SizedBox(width: 6),

        ],
      ),
    );
  }
}