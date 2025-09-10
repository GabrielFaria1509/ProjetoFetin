import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/views/feed/feed_page.dart';
import 'package:tism/views/profile/profile_page.dart';
import 'package:tism/views/chatbot/chat_screen.dart';
import 'package:tism/views/routine/routine_screen.dart';
import 'package:tism/views/diary/diary_screen.dart';
import 'package:tism/views/forum/forum_main.dart';
import 'package:tism/services/theme_service.dart';

class HomePage extends StatelessWidget {
  final String nomeUsuario;

  const HomePage({super.key, required this.nomeUsuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TISM - Guia TEA'),
        backgroundColor: Theme.of(context).brightness == Brightness.dark 
          ? const Color(0xFF1E1E1E) 
          : tismAqua,
        foregroundColor: Colors.white,
        elevation: Theme.of(context).brightness == Brightness.dark ? 0 : 4,
        actions: [],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, $nomeUsuario! 👋',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Explore conteúdos educativos sobre o TEA',
              style: TextStyle(
                fontSize: 16, 
                color: Theme.of(context).brightness == Brightness.dark 
                  ? Colors.grey[300] 
                  : Colors.grey[600]
              ),
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
                    'Rotina Personalizada',
                    Icons.schedule,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RoutineScreen()),
                    ),
                  ),
                  _buildMenuCard(
                    context,
                    'Diário de Observações',
                    Icons.book,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DiaryScreen()),
                    ),
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
                    'Fórum TEA',
                    Icons.forum,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForumMain()),
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
                Icon(
                  icon, 
                  size: 40, 
                  color: tismAqua,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).brightness == Brightness.dark 
                        ? Colors.white 
                        : Colors.black87
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.grey[400] 
                    : Colors.grey[600],
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
