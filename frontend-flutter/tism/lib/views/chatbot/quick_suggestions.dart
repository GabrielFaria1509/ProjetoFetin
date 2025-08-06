import 'package:flutter/material.dart';

class QuickSuggestions extends StatelessWidget {
  final Function(String) onSuggestionTap;
  
  const QuickSuggestions({super.key, required this.onSuggestionTap});

  static const List<Map<String, String>> _suggestions = [
    {
      'text': 'Como identificar autismo?',
      'icon': '🔍',
    },
    {
      'text': 'Meu filho não fala, é autismo?',
      'icon': '🗣️',
    },
    {
      'text': 'Que terapias funcionam?',
      'icon': '🎯',
    },
    {
      'text': 'Como ajudar na escola?',
      'icon': '🏫',
    },
    {
      'text': 'Direitos do autista',
      'icon': '⚖️',
    },
    {
      'text': 'Criança com birras',
      'icon': '😤',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = _suggestions[index];
          return Container(
            margin: const EdgeInsets.only(left: 8, right: 4),
            child: ActionChip(
              avatar: Text(suggestion['icon']!, style: const TextStyle(fontSize: 16)),
              label: Text(
                suggestion['text']!,
                style: const TextStyle(fontSize: 12),
              ),
              onPressed: () => onSuggestionTap(suggestion['text']!),
              backgroundColor: Colors.grey[100],
              side: BorderSide(color: Colors.grey[300]!),
            ),
          );
        },
      ),
    );
  }
}