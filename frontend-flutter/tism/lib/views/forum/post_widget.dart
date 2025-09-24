import 'package:flutter/material.dart';
import 'package:tism/l10n/app_localizations.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/widgets/account_badge.dart';

class PostWidget extends StatefulWidget {
  final Map<String, dynamic> post;
  final Function(String) onLike;
  final Function(String) onComment;
  final Function(String)? onDelete;

  const PostWidget({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
    this.onDelete,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> with TickerProviderStateMixin {
  late AnimationController _likeAnimationController;
  late Animation<double> _likeScaleAnimation;

  @override
  void initState() {
    super.initState();
    _likeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _likeScaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _likeAnimationController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _likeAnimationController.dispose();
    super.dispose();
  }

  void _handleLike() {
    widget.onLike(widget.post['id'].toString());
    if (widget.post['isLiked'] != true) {
      _likeAnimationController.forward().then((_) {
        _likeAnimationController.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header do post
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: tismAqua,
                  child: Text(
                    (widget.post['author'] ?? 'U')[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.post['author'] ?? 'Usuário',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 4),
                          AccountBadge(
                            accountType: widget.post['account_type'] ?? 'normal',
                            size: 20,
                          ),
                          if (widget.post['username'] != null) ...[
                            const SizedBox(width: 4),
                            Text(
                              '@${widget.post['username']}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        _formatTimestamp(widget.post['timestamp']),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.onDelete != null)
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'delete') {
                        widget.onDelete!(widget.post['id'].toString());
                      } else {
                        _handleMenuAction(context, value);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            const Icon(Icons.delete, color: Colors.red),
                            const SizedBox(width: 8),
                            Text(AppLocalizations.of(context)!.delete_post_action, style: const TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'report',
                        child: Row(
                          children: [
                            const Icon(Icons.flag_outlined),
                            const SizedBox(width: 8),
                            Text(AppLocalizations.of(context)!.report_post_action),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Conteúdo do post
            Text(
              widget.post['content']?.toString() ?? 'Sem conteúdo',
              style: const TextStyle(fontSize: 16, height: 1.4),
              maxLines: null,
            ),
            
            // Tags
            if (widget.post['tags'] != null && widget.post['tags'].isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: (widget.post['tags'] as List<String>).map((tag) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: tismAqua.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: tismAqua.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      '#$tag',
                      style: const TextStyle(
                        color: tismAqua,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            
            const SizedBox(height: 12),
            

            
            // Ações do post
            Row(
              children: [
                // Like com animação
                InkWell(
                  onTap: _handleLike,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBuilder(
                          animation: _likeAnimationController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: widget.post['isLiked'] == true ? 1.0 : _likeScaleAnimation.value,
                              child: Icon(
                                widget.post['isLiked'] == true ? Icons.favorite : Icons.favorite_border,
                                color: widget.post['isLiked'] == true ? Colors.red : Colors.grey[600],
                                size: 20,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.post['likes'] ?? 0}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Comentários
                InkWell(
                  onTap: () => widget.onComment(widget.post['id'].toString()),
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.post['comments'] ?? 0}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                

              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return 'Agora';
    
    DateTime dateTime;
    if (timestamp is String) {
      dateTime = DateTime.tryParse(timestamp) ?? DateTime.now();
    } else if (timestamp is DateTime) {
      dateTime = timestamp;
    } else {
      return 'Agora';
    }
    
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 1) {
      return AppLocalizations.of(context)!.now;
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}min';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'report':
        _showReportDialog(context);
        break;
      case 'share':
        // Implementar compartilhamento
        break;
    }
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.report_post_title),
        content: Text(AppLocalizations.of(context)!.report_post_confirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context)!.post_reported)),
              );
            },
            child: Text(AppLocalizations.of(context)!.report_post),
          ),
        ],
      ),
    );
  }
}