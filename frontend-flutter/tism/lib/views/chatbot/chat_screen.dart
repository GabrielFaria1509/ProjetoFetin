import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/l10n/app_localizations.dart';
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
  static const int _maxMessages = 30;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final l10n = AppLocalizations.of(context)!;
      _messages.add(ChatMessage(
        text: l10n.tina_welcome,
        isUser: false,
        avatarMood: 'smile',
      ));
      setState(() {});
    });
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
        title: Text(AppLocalizations.of(context)!.tina_assistant),
        backgroundColor: Theme.of(context).brightness == Brightness.dark 
          ? const Color(0xFF1E1E1E) 
          : tismAqua,
        foregroundColor: Colors.white,
        elevation: Theme.of(context).brightness == Brightness.dark ? 0 : 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report, color: Colors.white),
            onPressed: () => _testApiConnection(),
          ),
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
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(tismAqua),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.thinking, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            if (_messages.length <= 1)
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
                  hintText: AppLocalizations.of(context)!.type_message,
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 13),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: tismAqua),
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

    if (_messages.length >= _maxMessages) {
      _messages.removeRange(0, _messages.length - _maxMessages + 2);
    }

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isLoading = true;
    });

    _controller.clear();
    _scrollToBottom();

    final response = await ChatbotService.sendMessage(text, context);
    
    String messageText = response;
    String mood = 'smile';
    
    try {
      String jsonStr = response.trim();
      
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
  
  void _testApiConnection() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        title: Text('🔧 Testando API'),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Verificando conexão...'),
          ],
        ),
      ),
    );

    try {
      final response = await ChatbotService.sendMessage('teste', context);
      Navigator.of(context).pop();
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('✅ Resultado do Teste'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Status: Conexão OK', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Resposta da API:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    response.length > 200 ? '${response.substring(0, 200)}...' : response,
                    style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      Navigator.of(context).pop();
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('❌ Erro no Teste'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Status: Falha na conexão', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Erro:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  e.toString(),
                  style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                ),
              ),
              const SizedBox(height: 8),
              const Text('Verifique:', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('• Chave API no arquivo .env'),
              const Text('• Conexão com internet'),
              const Text('• Cota da API Gemini'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.about_tina),
        content: SingleChildScrollView(
          child: MarkdownBody(
            data: '${AppLocalizations.of(context)!.tina_intro}\n\n${AppLocalizations.of(context)!.tina_specialization}\n\n${AppLocalizations.of(context)!.tina_scientific}\n\n${AppLocalizations.of(context)!.tina_important}\n\n${AppLocalizations.of(context)!.tina_support}',
            styleSheet: MarkdownStyleSheet(
              p: const TextStyle(fontSize: 14, height: 1.4),
              strong: const TextStyle(fontWeight: FontWeight.bold, color: tismAqua),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.understood_tina),
          ),
        ],
      ),
    );
  }
}

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
                      listBullet: const TextStyle(
                        color: tismAqua,
                        fontSize: 14,
                      ),
                      h1: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: tismAqua,
                      ),
                      h2: const TextStyle(
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