import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/views/feed/resources_tab.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedCategory = 'Todos';
  final List<String> categories = [
    'Todos',
    'Diagnóstico',
    'Terapias',
    'Comportamento',
    'Educação',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> mockContent = [
    {
      'title': 'Sinais Precoces do TEA',
      'body':
          'Identificar os primeiros sinais do autismo pode fazer toda a diferença no desenvolvimento da criança...',
      'category': 'Diagnóstico',
      'author': 'Dr. Maria Silva',
      'published_at': '2024-12-19',
    },
    {
      'title': 'Terapia ABA: Como Funciona',
      'body':
          'A Análise do Comportamento Aplicada (ABA) é uma das terapias mais eficazes para crianças com TEA...',
      'category': 'Terapias',
      'author': 'Psicóloga Ana Costa',
      'published_at': '2024-12-18',
    },
    {
      'title': 'Rotinas e Estrutura',
      'body':
          'Estabelecer rotinas claras ajuda crianças com autismo a se sentirem mais seguras e organizadas...',
      'category': 'Comportamento',
      'author': 'Terapeuta João Santos',
      'published_at': '2024-12-17',
    },
  ];

  List<Map<String, dynamic>> get filteredContent {
    if (selectedCategory == 'Todos') return mockContent;
    return mockContent
        .where((content) => content['category'] == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed Educativo'),
        backgroundColor: tismAqua,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Artigos'),
            Tab(text: 'Recursos'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildArticlesTab(), const ResourcesTab()],
      ),
    );
  }

  Widget _buildArticlesTab() {
    return Column(
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = category == selectedCategory;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() => selectedCategory = category);
                  },
                  backgroundColor: Colors.grey[200],
                  selectedColor: tismAqua,
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredContent.length,
            itemBuilder: (context, index) {
              final content = filteredContent[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        content['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        content['body'],
                        style: const TextStyle(fontSize: 14),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            content['author'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            content['published_at'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
