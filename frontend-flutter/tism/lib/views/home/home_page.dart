import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/services/secure_storage_service.dart';
import 'package:tism/utils/text_utils.dart';
import 'package:tism/l10n/app_localizations.dart';

import 'package:tism/views/feed/feed_page.dart';
import 'package:tism/views/profile/profile_page.dart';
import 'package:tism/views/chatbot/chat_screen.dart';
import 'package:tism/views/routine/routine_screen.dart';
import 'package:tism/views/diary/diary_screen.dart';
import 'package:tism/views/forum/forum_main.dart';

class HomePage extends StatefulWidget {
  final String nomeUsuario;

  const HomePage({super.key, required this.nomeUsuario});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _displayName = '';
  String _motivationalPhrase = '';
  
  String get _phrase {
    final l10n = AppLocalizations.of(context)!;
    return l10n.explore_content;
  }

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _setRandomPhrase();
  }
  
  void _setRandomPhrase() {
    setState(() {
      _motivationalPhrase = _phrase;
    });
  }

  Future<void> _loadUserName() async {
    try {
      final fullName = await SecureStorageService.getSecureString('user_name') ?? widget.nomeUsuario;
      
      // Pegar apenas o primeiro nome e capitalizar
      final firstName = fullName.split(' ').first;
      final capitalizedName = firstName.isNotEmpty 
          ? firstName[0].toUpperCase() + firstName.substring(1).toLowerCase()
          : widget.nomeUsuario;
      
      setState(() {
        _displayName = capitalizedName;
      });
    } catch (e) {
      setState(() {
        _displayName = widget.nomeUsuario;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.app_name),
        backgroundColor: Theme.of(context).brightness == Brightness.dark 
          ? const Color(0xFF1E1E1E) 
          : tismAqua,
        foregroundColor: Colors.white,
        elevation: Theme.of(context).brightness == Brightness.dark ? 0 : 4,
        actions: const [],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.hello_user(_displayName.isNotEmpty ? _displayName : widget.nomeUsuario),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textDirection: TextUtils.getTextDirection(),
            ),
            const SizedBox(height: 8),
            Text(
              _motivationalPhrase,
              style: TextStyle(
                fontSize: 16, 
                color: Theme.of(context).brightness == Brightness.dark 
                  ? Colors.grey[300] 
                  : Colors.grey[600]
              ),
              textDirection: TextUtils.getTextDirection(),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _buildMenuCard(
                    context,
                    AppLocalizations.of(context)!.educational_feed,
                    Icons.article,
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FeedPage())),
                  ),
                  _buildMenuCard(
                    context,
                    AppLocalizations.of(context)!.custom_routine,
                    Icons.schedule,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RoutineScreen()),
                    ),
                  ),
                  _buildMenuCard(
                    context,
                    AppLocalizations.of(context)!.observation_diary,
                    Icons.book,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DiaryScreen()),
                    ),
                  ),
                  _buildMenuCardWithImage(
                    context,
                    AppLocalizations.of(context)!.tina_chatbot,
                    'assets/images/tinaSimpleIcon.png',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatScreen()),
                    ),
                  ),
                  _buildMenuCard(
                    context,
                    AppLocalizations.of(context)!.tea_forum,
                    Icons.forum,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForumMain()),
                    ),
                  ),

                  _buildMenuCard(
                    context,
                    AppLocalizations.of(context)!.profile,
                    Icons.person,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(nomeUsuario: widget.nomeUsuario),
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
                    textDirection: TextUtils.getTextDirection(),
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

  Widget _buildMenuCardWithImage(BuildContext context, String title, String imagePath, VoidCallback onTap) {
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
                Image.asset(
                  imagePath,
                  width: 42,
                  height: 42,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => 
                    const Icon(Icons.chat, size: 42, color: tismAqua),
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
                    textDirection: TextUtils.getTextDirection(),
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