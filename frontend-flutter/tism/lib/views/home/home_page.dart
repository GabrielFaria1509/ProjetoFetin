import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/services/secure_storage_service.dart';
import 'dart:math';
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
  
  final List<String> _phrases = [
    'Explore conteúdos educativos sobre o TEA',
    'Descubra recursos para apoiar o desenvolvimento',
    'Conecte-se com informações especializadas',
    'Acesse ferramentas para o dia a dia',
    'Encontre suporte e orientação personalizada', 
    'Navegue por conteúdos baseados em evidências',
    'Construa rotinas adaptadas às necessidades',
    'Cada pessoa com TEA é única e especial',
    'Desenvolva habilidades no seu próprio ritmo',
    'Celebre cada pequena conquista',
    'A jornada do TEA é única para cada família',
    'Conhecimento é a chave para a compreensão',
    'Juntos somos mais fortes na jornada do TEA',
    'Compartilhe experiências no nosso fórum',
    'Registre os progressos no diário',
    'Organize melhor a rotina diária',
    'Aprenda mais sobre comunicação alternativa',
    'Descubra estratégias sensoriais efetivas',
    'Conecte-se com outros pais e cuidadores',
    'Acompanhe o desenvolvimento passo a passo',
    'Encontre dicas práticas para o dia a dia',
    'Personalize as atividades conforme a necessidade',
    'Mantenha-se informado sobre o TEA',
    'Construa uma rede de apoio sólida',
    'Explore diferentes abordagens terapêuticas',
    'Aprenda sobre integração sensorial',
    'Desenvolva estratégias de autorregulação',
    'Fortaleça vínculos familiares',
    'Promova a independência gradualmente',
    'Celebre a neurodiversidade',
    'Encontre recursos educacionais específicos',
    'Aprenda sobre comunicação efetiva',
    'Desenvolva habilidades sociais passo a passo',
    'Explore atividades sensoriais benéficas',
    'Construa uma rotina previsível e segura',
    'Acompanhe marcos do desenvolvimento',
    'Registre comportamentos importantes',
    'Identifique gatilhos e padrões',
    'Planeje transições suaves no dia a dia',
    'Desenvolva estratégias de calma',
    'Aprenda sobre alimentação seletiva',
    'Explore técnicas de sono saudável',
    'Encontre suporte profissional especializado',
    'Compartilhe sucessos e desafios',
    'Mantenha um registro de progressos',
    'Adapte o ambiente para maior conforto',
    'Aprenda sobre processamento sensorial',
    'Desenvolva a autonomia com segurança',
    'Explore interesses específicos',
    'Construa pontes de comunicação',
    'Fortaleça habilidades motoras',
    'Promova interações sociais positivas',
    'Aprenda sobre autorregulação emocional',
    'Desenvolva rotinas de autocuidado',
    'Explore recursos visuais de apoio',
    'Construa histórias sociais personalizadas',
    'Acompanhe o progresso educacional',
    'Registre conquistas importantes',
    'Identifique pontos fortes e talentos',
    'Planeje atividades estruturadas',
    'Desenvolva habilidades de vida diária',
    'Aprenda sobre suporte comportamental',
    'Explore terapias complementares',
    'Encontre estratégias de inclusão escolar',
    'Compartilhe momentos especiais',
    'Mantenha a consistência na rotina',
    'Adapte comunicação às necessidades',
    'Aprenda sobre desenvolvimento sensorial',
    'Desenvolva habilidades de brincadeira',
    'Explore atividades terapêuticas em casa',
    'Construa um ambiente de aprendizagem',
    'Fortaleça a comunicação familiar',
    'Promova independência nas atividades',
    'Aprenda sobre gestão de ansiedade',
    'Desenvolva estratégias de foco',
    'Explore recursos de tecnologia assistiva',
    'Construa momentos de conexão',
    'Acompanhe mudanças de comportamento',
    'Registre estratégias efetivas',
    'Identifique interesses especiais',
    'Planeje atividades sensoriais',
    'Desenvolva habilidades de organização',
    'Converse com Tina, nossa assistente virtual',
    'Tire suas dúvidas sobre TEA',
    'Encontre apoio na nossa comunidade'
  ];

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _setRandomPhrase();
  }
  
  void _setRandomPhrase() {
    final random = Random();
    setState(() {
      _motivationalPhrase = _phrases[random.nextInt(_phrases.length)];
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
              'Olá, ${_displayName.isNotEmpty ? _displayName : widget.nomeUsuario}! 👋',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  _buildMenuCardWithImage(
                    context,
                    'Tina (Chatbot)',
                    'assets/images/tinaSimpleIcon.png',
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
                    Icon(Icons.chat, size: 42, color: tismAqua),
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
