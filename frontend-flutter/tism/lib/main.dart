import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tism/constants/theme.dart';
import 'package:tism/services/theme_service.dart';
import 'package:tism/services/language_service.dart';
import 'package:tism/services/pwa_service.dart' 
    if (dart.library.html) 'package:tism/services/pwa_service.dart'
    if (dart.library.io) 'package:tism/services/pwa_service_stub.dart';
import 'package:tism/views/login/login_startup.dart';
import 'package:tism/views/home/home_page.dart';
import 'package:tism/services/secure_storage_service.dart';
import 'package:tism/widgets/pwa_status_widget.dart';
import 'package:tism/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    // Erro ao carregar .env silencioso
  }
  
  // Inicializar serviços
  await languageService.initialize();
  
  // Inicializar PWA service apenas na web
  if (kIsWeb) {
    await PWAService().initialize();
  }
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeService()),
        ChangeNotifierProvider.value(value: languageService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService>(
      builder: (context, themeService, languageService, child) {
        final app = MaterialApp(
          title: 'TISM - Tudo sobre TEA',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeService.themeMode,
          locale: languageService.currentLocale,
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
        
        // Envolver com PWA status widget apenas na web
        return kIsWeb 
          ? PWAStatusWidget(child: app)
          : app;
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