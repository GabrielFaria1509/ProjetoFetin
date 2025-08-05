import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/views/feed/feed_page.dart';
import 'package:tism/views/profile/profile_page.dart';
import 'package:tism/views/chatbot/chat_screen.dart';

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
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
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
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatScreen()),
                    ),
                  ),

                  _buildMenuCard(
                    context,
                    'Perfil',
                    Icons.person,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(nomeUsuario: nomeUsuario),
                      ),
                    ),
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
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 4,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(icon, size: 40, color: tismAqua),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
