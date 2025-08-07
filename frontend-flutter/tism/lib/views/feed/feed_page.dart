import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/views/feed/resources_tab.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed Educativo'),
        backgroundColor: tismAqua,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Artigos', icon: Icon(Icons.article)),
            Tab(text: 'Recursos PDF', icon: Icon(Icons.picture_as_pdf)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildArticlesTab(),
          const ResourcesTab(),
        ],
      ),
    );
  }

  Widget _buildArticlesTab() {
    final mockContent = [
      {
        'title': 'Sinais Precoces do TEA',
        'body': 'Identificar os primeiros sinais do autismo pode fazer toda a diferença no desenvolvimento da criança. Este artigo aborda os principais indicadores que pais e profissionais devem observar.',
        'author': 'Dr. Maria Silva',
        'published_at': '2024-12-19',
      },
      {
        'title': 'Terapia ABA: Como Funciona',
        'body': 'A Análise do Comportamento Aplicada (ABA) é uma das terapias mais eficazes para crianças com TEA. Conheça os princípios e benefícios desta abordagem terapêutica.',
        'author': 'Psicóloga Ana Costa',
        'published_at': '2024-12-18',
      },
      {
        'title': 'Rotinas e Estrutura no TEA',
        'body': 'Estabelecer rotinas claras ajuda crianças com autismo a se sentirem mais seguras e organizadas. Aprenda estratégias práticas para implementar estruturas eficazes.',
        'author': 'Terapeuta João Santos',
        'published_at': '2024-12-17',
      },
      {
        'title': 'Inclusão Escolar: Direitos e Práticas',
        'body': 'A inclusão escolar é um direito garantido por lei. Conheça as principais estratégias para promover um ambiente educacional inclusivo e acolhedor.',
        'author': 'Pedagoga Carla Lima',
        'published_at': '2024-12-16',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockContent.length,
      itemBuilder: (context, index) {
        final content = mockContent[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content['title']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content['body']!,
                  style: const TextStyle(fontSize: 14),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      content['author']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      content['published_at']!,
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
    );
  }
}
