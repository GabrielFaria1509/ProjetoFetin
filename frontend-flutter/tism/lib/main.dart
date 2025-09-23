import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tism/constants/theme.dart';
import 'package:tism/services/theme_service.dart';
import 'package:tism/services/language_service.dart';
import 'package:tism/views/login/login_startup.dart';
import 'package:tism/views/home/home_page.dart';
import 'package:tism/services/secure_storage_service.dart';
import 'package:tism/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    // Erro ao carregar .env silencioso
  }
  
  // Inicializar serviço de idiomas
  await languageService.initialize();
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return MaterialApp(
          title: 'TISM App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeService.themeMode,
          locale: const Locale('pt'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt'),
            Locale('en'),
            Locale('fr'),
            Locale('es'),
            Locale('de'),
            Locale('ru'),
            Locale('ja'),
            Locale('it'),
            Locale('ko'),
            Locale('tr'),
            Locale('hi'),
            Locale('ar'),
            Locale('zh'),
          ],
          home: const InitialScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    try {
      final userId = await SecureStorageService.getSecureInt('user_id');
      final userName = await SecureStorageService.getSecureString('user_name');
      
      if (mounted) {
        if (userId != null && userName != null && userName.isNotEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomePage(nomeUsuario: userName),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginStartup()),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginStartup()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}