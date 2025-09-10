import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/services/forum_service.dart';
import 'post_widget.dart';
import 'comments_screen.dart';

class ForumFeed extends StatefulWidget {
  const ForumFeed({super.key});

  @override
  State<ForumFeed> createState() => _ForumFeedState();
}

class _ForumFeedState extends State<ForumFeed> {
  List<Map<String, dynamic>> posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPosts();
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
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostWidget(
            post: posts[index],
            onLike: (postId) => _toggleLike(postId),
            onSave: (postId) => _toggleSave(postId),
            onComment: (postId) => _openComments(postId),
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
        ],
      ),
    );
  }

  Future<void> _toggleLike(String postId) async {
    final success = await ForumService.likePost(int.parse(postId));
    if (success) {
      // Recarregar posts para ter estado atualizado
      await _loadPosts();
    }
  }

  Future<void> _toggleSave(String postId) async {
    final success = await ForumService.savePost(int.parse(postId));
    if (success) {
      setState(() {
        final post = posts.firstWhere((p) => p['id'].toString() == postId);
        post['isSaved'] = !post['isSaved'];
      });
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
    ).then((_) => _loadPosts()); // Recarregar posts ao voltar
  }
}