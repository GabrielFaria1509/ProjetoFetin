import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/services/theme_service.dart';
import 'forum_feed.dart';
import 'forum_following.dart';
import 'forum_liked.dart';
import 'forum_saved.dart';
import 'forum_search.dart';
import 'create_post_screen.dart';

class ForumMain extends StatefulWidget {
  const ForumMain({super.key});

  @override
  State<ForumMain> createState() => _ForumMainState();
}

class _ForumMainState extends State<ForumMain> with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fórum TEA'),
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : tismAqua,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Consumer<ThemeService>(
            builder: (context, themeService, child) {
              return IconButton(
                icon: Icon(
                  themeService.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: Colors.white,
                ),
                onPressed: () => themeService.toggleTheme(),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: 'Feed'),
            Tab(icon: Icon(Icons.people), text: 'Seguindo'),
            Tab(icon: Icon(Icons.favorite), text: 'Curtidas'),
            Tab(icon: Icon(Icons.bookmark), text: 'Salvos'),
            Tab(icon: Icon(Icons.search), text: 'Buscar'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ForumFeed(),
          ForumFollowing(),
          ForumLiked(),
          ForumSaved(),
          ForumSearch(),
        ],
      ),
      floatingActionButton: _currentIndex == 0 ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePostScreen()),
          );
        },
        backgroundColor: tismAqua,
        child: const Icon(Icons.add, color: Colors.white),
      ) : null,
    );
  }
}