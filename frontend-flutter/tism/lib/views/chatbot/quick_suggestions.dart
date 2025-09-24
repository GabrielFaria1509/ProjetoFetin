import 'package:flutter/material.dart';
import 'package:tism/l10n/app_localizations.dart';

class QuickSuggestions extends StatelessWidget {
  final Function(String) onSuggestionTap;
  
  const QuickSuggestions({super.key, required this.onSuggestionTap});

  List<Map<String, String>> _getSuggestions(AppLocalizations l10n) {
    return [
      {
        'text': l10n.how_identify_autism,
        'icon': '🔍',
      },
      {
        'text': l10n.child_not_speaking,
        'icon': '🗣️',
      },
      {
        'text': l10n.what_therapies_work,
        'icon': '🎯',
      },
      {
        'text': l10n.help_at_school,
        'icon': '🏫',
      },
      {
        'text': l10n.autism_rights,
        'icon': '⚖️',
      },
      {
        'text': l10n.child_tantrums,
        'icon': '😤',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final l10n = AppLocalizations.of(context)!;
    final suggestions = _getSuggestions(l10n);
    
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return Container(
            margin: const EdgeInsets.only(left: 8, right: 4),
            child: ActionChip(
              avatar: Text(suggestion['icon']!, style: const TextStyle(fontSize: 16)),
              label: Text(
                suggestion['text']!,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              onPressed: () => onSuggestionTap(suggestion['text']!),
              backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.grey[100],
              side: BorderSide(
                color: isDark ? Colors.grey[600]! : Colors.grey[300]!,
              ),
            ),
          );
        },
      ),
    );

  }
}