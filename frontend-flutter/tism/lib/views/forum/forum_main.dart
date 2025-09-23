import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/services/language_service.dart';
import 'forum_feed.dart';

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
    _tabController = TabController(length: 2, vsync: this);
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
        title: Text('tea_forum'.tr),
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : tismAqua,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: const [],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: const Icon(Icons.home), text: 'feed'.tr),
            Tab(icon: const Icon(Icons.search), text: 'search'.tr),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ForumFeed(),
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