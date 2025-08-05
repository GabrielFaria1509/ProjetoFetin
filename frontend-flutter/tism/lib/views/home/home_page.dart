import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/views/feed/feed_page.dart';

class HomePage extends StatelessWidget {
  final String nomeUsuario;

  const HomePage({super.key, required this.nomeUsuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TISM - Guia TEA'),
        backgroundColor: tismAqua,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, $nomeUsuario! 👋',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Explore conteúdos educativos sobre o TEA',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    context,
                    'Feed Educativo',
                    Icons.article,
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FeedPage())),
                  ),
                  _buildMenuCard(
                    context,
                    'Chatbot',
                    Icons.chat,
                    () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Em breve!')),
                    ),
                  ),
                  _buildMenuCard(
                    context,
                    'Recursos',
                    Icons.library_books,
                    () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Em breve!')),
                    ),
                  ),
                  _buildMenuCard(
                    context,
                    'Perfil',
                    Icons.person,
                    () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: tismAqua),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
