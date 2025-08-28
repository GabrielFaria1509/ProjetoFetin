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
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              text: 'Artigos', 
              icon: Icon(Icons.article, color: Colors.white),
            ),
            Tab(
              text: 'Biblioteca Digital', 
              icon: Icon(Icons.library_books, color: Colors.white),
            ),
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
        'body': 'Identificar os primeiros sinais do autismo pode fazer toda a diferença no desenvolvimento da criança. Os principais indicadores incluem:\n\n• Dificuldades na comunicação verbal e não-verbal\n• Padrões repetitivos de comportamento\n• Interesses restritos e intensos\n• Dificuldades na interação social\n• Sensibilidade sensorial alterada\n\nÉ importante observar que cada criança é única e pode apresentar diferentes combinações destes sinais. O diagnóstico precoce permite intervenções mais eficazes.',
        'author': 'Dr. Maria Silva',
        'published_at': '2024-12-19',
      },
      {
        'title': 'Terapia ABA: Como Funciona',
        'body': 'A Análise do Comportamento Aplicada (ABA) é uma das terapias mais eficazes para crianças com TEA. Esta abordagem científica baseia-se em princípios do comportamento para ensinar habilidades e reduzir comportamentos problemáticos.\n\nPrincípios fundamentais da ABA:\n• Reforço positivo para comportamentos desejados\n• Quebra de habilidades complexas em passos menores\n• Coleta de dados para monitorar progresso\n• Individualização do programa para cada criança\n\nA terapia ABA pode ajudar no desenvolvimento de habilidades de comunicação, sociais, acadêmicas e de vida diária.',
        'author': 'Psicóloga Ana Costa',
        'published_at': '2024-12-18',
      },
      {
        'title': 'Rotinas e Estrutura no TEA',
        'body': 'Estabelecer rotinas claras ajuda crianças com autismo a se sentirem mais seguras e organizadas. A previsibilidade reduz a ansiedade e facilita a participação em atividades diárias.\n\nEstratégias para criar rotinas eficazes:\n• Use apoios visuais como calendários e cronogramas\n• Mantenha horários consistentes para refeições e sono\n• Prepare a criança para mudanças com antecedência\n• Crie rituais de transição entre atividades\n• Estabeleça locais específicos para diferentes atividades\n\nLembre-se de que flexibilidade também é importante - ajuste as rotinas conforme necessário.',
        'author': 'Terapeuta João Santos',
        'published_at': '2024-12-17',
      },
      {
        'title': 'Inclusão Escolar: Direitos e Práticas',
        'body': 'A inclusão escolar é um direito garantido por lei no Brasil. A Lei Brasileira de Inclusão (LBI) assegura o acesso à educação de qualidade para pessoas com deficiência.\n\nPrincipais direitos:\n• Matrícula em escola regular\n• Atendimento educacional especializado\n• Adaptações curriculares quando necessárias\n• Profissional de apoio escolar\n• Materiais didáticos acessíveis\n\nPara uma inclusão efetiva, é essencial a colaboração entre família, escola e profissionais especializados. O ambiente escolar deve ser acolhedor e preparado para atender às necessidades específicas de cada estudante.',
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
                  style: const TextStyle(fontSize: 14, height: 1.5),
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
