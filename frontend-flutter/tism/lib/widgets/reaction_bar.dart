import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tism/constants/colors.dart';

class ReactionBar extends StatefulWidget {
  final Map<String, int> reactionCounts;
  final String? userReaction;
  final Function(String) onReaction;

  const ReactionBar({
    super.key,
    required this.reactionCounts,
    this.userReaction,
    required this.onReaction,
  });

  @override
  State<ReactionBar> createState() => _ReactionBarState();
}

class _ReactionBarState extends State<ReactionBar> with TickerProviderStateMixin {
  static const Map<String, String> reactions = {
    'like': '👍',
    'love': '❤️',
    'clap': '👏',
    'star': '🌟',
    'idea': '💡',
    'target': '🎯',
    'handshake': '🤝',
    'sad': '😢',
    'angry': '😠',
    'hug': '🤗',
    'muscle': '💪',
    'pray': '🙏',
    'party': '🎉',
  };

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleReaction(String reactionType) {
    HapticFeedback.lightImpact();
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    widget.onReaction(reactionType);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasReactions = widget.reactionCounts.values.any((count) => count > 0);
    
    if (!hasReactions && widget.userReaction == null) {
      // Mostrar apenas botão de adicionar reação se não houver nenhuma
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: PopupMenuButton<String>(
          icon: Icon(
            Icons.add_reaction_outlined,
            size: 20,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
          tooltip: 'Adicionar reação',
          onSelected: _handleReaction,
          itemBuilder: (context) => reactions.entries
              .map((entry) => PopupMenuItem<String>(
                    value: entry.key,
                    child: Row(
                      children: [
                        Text(entry.value, style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 8),
                        Text(_getReactionLabel(entry.key)),
                      ],
                    ),
                  ))
              .toList(),
        ),
      );
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800]?.withOpacity(0.5) : Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Reações principais (mais usadas)
          ...['like', 'love', 'clap', 'star']
              .where((type) => widget.reactionCounts[type] != null && widget.reactionCounts[type]! > 0 || widget.userReaction == type)
              .map((type) => _buildReactionButton(type)),
          
          // Outras reações com contagem
          ...reactions.keys
              .where((type) => !['like', 'love', 'clap', 'star'].contains(type))
              .where((type) => widget.reactionCounts[type] != null && widget.reactionCounts[type]! > 0 || widget.userReaction == type)
              .map((type) => _buildReactionButton(type)),
          
          // Botão "mais reações"
          PopupMenuButton<String>(
            icon: Icon(
              Icons.add_reaction_outlined,
              size: 18,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
            tooltip: 'Mais reações',
            onSelected: _handleReaction,
            itemBuilder: (context) => reactions.entries
                .map((entry) => PopupMenuItem<String>(
                      value: entry.key,
                      child: Row(
                        children: [
                          Text(entry.value, style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 8),
                          Text(_getReactionLabel(entry.key)),
                          if (widget.reactionCounts[entry.key] != null && widget.reactionCounts[entry.key]! > 0) ...[
                            const Spacer(),
                            Text(
                              '${widget.reactionCounts[entry.key]}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReactionButton(String type) {
    final count = widget.reactionCounts[type] ?? 0;
    final isSelected = widget.userReaction == type;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: isSelected ? _scaleAnimation.value : 1.0,
          child: GestureDetector(
            onTap: () => _handleReaction(type),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected 
                    ? tismAqua.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: isSelected 
                    ? Border.all(color: tismAqua, width: 1)
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    reactions[type]!,
                    style: TextStyle(
                      fontSize: isSelected ? 18 : 16,
                    ),
                  ),
                  if (count > 0) ...[
                    const SizedBox(width: 4),
                    Text(
                      count.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected 
                            ? tismAqua
                            : (isDark ? Colors.grey[400] : Colors.grey[600]),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getReactionLabel(String type) {
    const labels = {
      'idea': 'Ideia',
      'target': 'Objetivo',
      'handshake': 'Apoio',
      'sad': 'Triste',
      'angry': 'Irritado',
      'hug': 'Abraço',
      'muscle': 'Força',
      'pray': 'Oração',
      'party': 'Festa',
    };
    return labels[type] ?? type;
  }
}