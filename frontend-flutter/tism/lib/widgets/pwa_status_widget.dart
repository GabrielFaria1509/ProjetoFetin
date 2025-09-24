import 'package:flutter/material.dart';
import '../services/pwa_service.dart';

class PWAStatusWidget extends StatefulWidget {
  final Widget child;
  
  const PWAStatusWidget({
    super.key,
    required this.child,
  });

  @override
  State<PWAStatusWidget> createState() => _PWAStatusWidgetState();
}

class _PWAStatusWidgetState extends State<PWAStatusWidget> {
  final PWAService _pwaService = PWAService();
  bool _isOnline = true;
  bool _showInstallBanner = false;

  @override
  void initState() {
    super.initState();
    _initializePWA();
  }

  Future<void> _initializePWA() async {
    await _pwaService.initialize();
    
    _pwaService.onConnectivityChanged = (isOnline) {
      setState(() {
        _isOnline = isOnline;
      });
      
      if (!isOnline) {
        _showOfflineSnackBar();
      } else {
        _showOnlineSnackBar();
      }
    };
    
    _pwaService.onInstallPromptReady = () {
      setState(() {
        _showInstallBanner = true;
      });
    };
    
    setState(() {
      _isOnline = _pwaService.isOnline;
      _showInstallBanner = _pwaService.isInstallable && !_pwaService.isPWA;
    });
  }

  void _showOfflineSnackBar() {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.wifi_off, color: Colors.white),
            SizedBox(width: 8),
            Text('Você está offline. Algumas funcionalidades podem estar limitadas.'),
          ],
        ),
        backgroundColor: Colors.orange[700],
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  void _showOnlineSnackBar() {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.wifi, color: Colors.white),
            SizedBox(width: 8),
            Text('Conectado! Sincronizando dados...'),
          ],
        ),
        backgroundColor: Colors.green[700],
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _handleInstall() async {
    final installed = await _pwaService.showInstallPrompt();
    if (installed) {
      setState(() {
        _showInstallBanner = false;
      });
    }
  }

  void _dismissInstallBanner() {
    setState(() {
      _showInstallBanner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        
        // Status de conectividade
        if (!_isOnline)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              color: Colors.orange[700],
              child: SafeArea(
                bottom: false,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off, color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Modo Offline',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Tentar reconectar
                      },
                      child: const Text(
                        'Tentar novamente',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        
        // Banner de instalação
        if (_showInstallBanner)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.download,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Instalar TISM',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Acesso rápido e experiência nativa',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: _handleInstall,
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: const Text('Instalar'),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: _dismissInstallBanner,
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white70,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _pwaService.dispose();
    super.dispose();
  }
}

class PWAInstallButton extends StatefulWidget {
  const PWAInstallButton({super.key});

  @override
  State<PWAInstallButton> createState() => _PWAInstallButtonState();
}

class _PWAInstallButtonState extends State<PWAInstallButton> {
  final PWAService _pwaService = PWAService();
  bool _isInstallable = false;

  @override
  void initState() {
    super.initState();
    _checkInstallability();
  }

  void _checkInstallability() {
    setState(() {
      _isInstallable = _pwaService.isInstallable && !_pwaService.isPWA;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInstallable) {
      return const SizedBox.shrink();
    }

    return FloatingActionButton.extended(
      onPressed: () async {
        final installed = await _pwaService.showInstallPrompt();
        if (installed) {
          setState(() {
            _isInstallable = false;
          });
        }
      },
      icon: const Icon(Icons.download),
      label: const Text('Instalar App'),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}

class PWAUpdateWidget extends StatefulWidget {
  const PWAUpdateWidget({super.key});

  @override
  State<PWAUpdateWidget> createState() => _PWAUpdateWidgetState();
}

class _PWAUpdateWidgetState extends State<PWAUpdateWidget> {
  final PWAService _pwaService = PWAService();
  bool _updateAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkForUpdates();
  }

  Future<void> _checkForUpdates() async {
    final hasUpdate = await _pwaService.checkForUpdates();
    setState(() {
      _updateAvailable = hasUpdate;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_updateAvailable) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.system_update,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Atualização Disponível',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Uma nova versão do TISM está disponível',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              // Recarregar a página para aplicar a atualização
              if (mounted) {
                Navigator.of(context).pushReplacementNamed('/');
              }
            },
            child: const Text('Atualizar'),
          ),
        ],
      ),
    );
  }
}