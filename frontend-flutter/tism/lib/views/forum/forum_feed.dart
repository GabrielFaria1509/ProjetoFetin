import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'post_widget.dart';

class ForumFeed extends StatefulWidget {
  const ForumFeed({super.key});

  @override
  State<ForumFeed> createState() => _ForumFeedState();
}

class _ForumFeedState extends State<ForumFeed> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _posts = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPosts();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMorePosts();
    }
  }

  Future<void> _loadPosts() async {
    setState(() => _isLoading = true);
    
    // Simular carregamento de posts
    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      _posts = [
        {
          'id': '1',
          'author': 'Maria Silva',
          'avatar': null,
          'content': 'Compartilhando uma experiência incrível com meu filho autista hoje! 💙',
          'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
          'likes': 15,
          'comments': 3,
          'isLiked': false,
          'isSaved': false,
          'tags': ['experiência', 'progresso'],
        },
        {
          'id': '2',
          'author': 'João Santos',
          'avatar': null,
          'content': 'Alguém tem dicas de atividades sensoriais para crianças de 5 anos?',
          'timestamp': DateTime.now().subtract(const Duration(hours: 4)),
          'likes': 8,
          'comments': 12,
          'isLiked': true,
          'isSaved': false,
          'tags': ['dicas', 'atividades', 'sensorial'],
        },
      ];
      _isLoading = false;
    });
  }

  Future<void> _loadMorePosts() async {
    // Implementar lazy loading
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && _posts.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: tismAqua),
      );
    }

    if (_posts.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _loadPosts,
      color: tismAqua,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(8),
        itemCount: _posts.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _posts.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(color: tismAqua),
              ),
            );
          }
          
          return PostWidget(
            post: _posts[index],
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
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Navegar para criar post
            },
            icon: const Icon(Icons.add),
            label: const Text('Criar Primeiro Post'),
            style: ElevatedButton.styleFrom(
              backgroundColor: tismAqua,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleLike(String postId) {
    setState(() {
      final post = _posts.firstWhere((p) => p['id'] == postId);
      post['isLiked'] = !post['isLiked'];
      post['likes'] += post['isLiked'] ? 1 : -1;
    });
  }

  void _toggleSave(String postId) {
    setState(() {
      final post = _posts.firstWhere((p) => p['id'] == postId);
      post['isSaved'] = !post['isSaved'];
    });
  }

  void _openComments(String postId) {
    // Implementar tela de comentários
  }
}