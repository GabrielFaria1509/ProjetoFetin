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
    final hasReactions = widget.reactionCounts.values.any((count) => count > 0) || widget.userReaction != null;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[50],
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Sempre mostrar as 4 reações principais
          ...['like', 'love', 'clap', 'star'].map((type) => _buildReactionButton(type)),
          
          // Outras reações ativas
          ...reactions.keys
              .where((type) => !['like', 'love', 'clap', 'star'].contains(type))
              .where((type) => (widget.reactionCounts[type] ?? 0) > 0 || widget.userReaction == type)
              .map((type) => _buildReactionButton(type)),
          
          // Separador
          if (hasReactions) Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 20,
            width: 1,
            color: isDark ? Colors.grey[600] : Colors.grey[300],
          ),
          
          // Botão "mais reações"
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.add_reaction_outlined,
              size: 20,
              color: tismAqua,
            ),
            tooltip: 'Adicionar reação',
            onSelected: _handleReaction,
            itemBuilder: (context) => reactions.entries
                .map((entry) => PopupMenuItem<String>(
                      value: entry.key,
                      child: Row(
                        children: [
                          Text(entry.value, style: const TextStyle(fontSize: 22)),
                          const SizedBox(width: 12),
                          Expanded(child: Text(_getReactionLabel(entry.key))),
                          if ((widget.reactionCounts[entry.key] ?? 0) > 0) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: tismAqua.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${widget.reactionCounts[entry.key]}',
                                style: const TextStyle(
                                  color: tismAqua,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
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
    final showCount = count > 0;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: isSelected ? _scaleAnimation.value : 1.0,
          child: GestureDetector(
            onTap: () => _handleReaction(type),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected 
                    ? tismAqua.withValues(alpha: 0.15)
                    : (showCount ? (isDark ? Colors.grey[800] : Colors.grey[100]) : Colors.transparent),
                borderRadius: BorderRadius.circular(18),
                border: isSelected 
                    ? Border.all(color: tismAqua, width: 1.5)
                    : (showCount ? Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[300]!, width: 1) : null),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    reactions[type]!,
                    style: TextStyle(
                      fontSize: isSelected ? 20 : 18,
                    ),
                  ),
                  if (showCount) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? tismAqua
                            : (isDark ? Colors.grey[600] : Colors.grey[400]),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        count.toString(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: isSelected 
                              ? Colors.white
                              : (isDark ? Colors.white : Colors.white),
                        ),
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