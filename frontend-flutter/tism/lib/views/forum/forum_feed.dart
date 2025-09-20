import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/services/forum_service.dart';
import 'package:tism/services/secure_storage_service.dart';
import 'post_widget.dart';
import 'comments_screen.dart';
import 'create_post_screen.dart';

class ForumFeed extends StatefulWidget {
  const ForumFeed({super.key});

  @override
  State<ForumFeed> createState() => _ForumFeedState();
}

class _ForumFeedState extends State<ForumFeed> {
  List<Map<String, dynamic>> posts = [];
  bool _isLoading = true;
  int? _currentUserId;
  final Set<String> _likingPosts = {}; // Posts sendo processados

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    _loadPosts();
  }

  Future<void> _loadCurrentUser() async {
    _currentUserId = await SecureStorageService.getSecureInt('user_id');
  }

  Future<void> _loadPosts() async {
    setState(() => _isLoading = true);
    
    final loadedPosts = await ForumService.getPosts();
    
    if (mounted) {
      setState(() {
        posts = loadedPosts;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: tismAqua),
      );
    }

    if (posts.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _loadPosts,
      color: tismAqua,
      backgroundColor: Colors.white,
      strokeWidth: 3,
      displacement: 60,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostWidget(
            post: posts[index],
            onLike: (postId) => _toggleLike(postId),
            onComment: (postId) => _openComments(postId),
            onDelete: _canDeletePost(posts[index]) ? (postId) => _deletePost(postId) : null,
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.forum_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Bem-vindo ao Fórum TEA! 💙',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Seja o primeiro a compartilhar uma experiência\nou fazer uma pergunta para a comunidade',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreatePostScreen()),
              ).then((_) => _loadPosts());
            },
            icon: const Icon(Icons.add),
            label: const Text('Criar primeiro post'),
            style: ElevatedButton.styleFrom(
              backgroundColor: tismAqua,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleLike(String postId) async {
    // Evitar spam
    if (_likingPosts.contains(postId)) return;
    _likingPosts.add(postId);
    
    // Atualizar UI imediatamente
    setState(() {
      final postIndex = posts.indexWhere((p) => p['id'].toString() == postId);
      if (postIndex != -1) {
        final post = posts[postIndex];
        final wasLiked = post['isLiked'] == true;
        post['isLiked'] = !wasLiked;
        post['likes'] = (post['likes'] ?? 0) + (wasLiked ? -1 : 1);
      }
    });
    
    try {
      // Enviar IMEDIATAMENTE para servidor
      await ForumService.likePost(int.parse(postId));
    } catch (e) {
      // Se falhar, reverter UI
      setState(() {
        final postIndex = posts.indexWhere((p) => p['id'].toString() == postId);
        if (postIndex != -1) {
          final post = posts[postIndex];
          final wasLiked = post['isLiked'] == true;
          post['isLiked'] = !wasLiked;
          post['likes'] = (post['likes'] ?? 0) + (wasLiked ? -1 : 1);
        }
      });
    } finally {
      _likingPosts.remove(postId);
    }
  }



  void _openComments(String postId) {
    final post = posts.firstWhere((p) => p['id'].toString() == postId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentsScreen(
          postId: postId,
          post: post,
        ),
      ),
    ).then((result) {
      // Atualizar contador se novo comentário foi adicionado
      if (result == true) {
        setState(() {
          final postIndex = posts.indexWhere((p) => p['id'].toString() == postId);
          if (postIndex != -1) {
            posts[postIndex]['comments'] = (posts[postIndex]['comments'] ?? 0) + 1;
          }
        });
      }
    });
  }

  bool _canDeletePost(Map<String, dynamic> post) {
    // Verificar se o usuário atual é o autor do post
    return post['user_id']?.toString() == _currentUserId?.toString();
  }

  Future<void> _deletePost(String postId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deletar Post'),
        content: const Text('Tem certeza que deseja deletar este post? Esta ação não pode ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Deletar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await ForumService.deletePost(postId, _currentUserId.toString());
        setState(() {
          posts.removeWhere((post) => post['id'].toString() == postId);
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Post deletado com sucesso'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao deletar post: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}