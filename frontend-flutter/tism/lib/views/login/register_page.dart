import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/services/auth_integration_service.dart';
import 'package:tism/l10n/app_localizations.dart';
import 'package:tism/views/login/email_verification_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();
  String _userType = 'Participante';
  bool _isLoading = false;
  String? erro;

  Future<void> _registrar() async {
    final nome = nomeController.text.trim();
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final senha = senhaController.text;
    final confirmar = confirmarSenhaController.text;

    setState(() => erro = null);

    if (nome.isEmpty || username.isEmpty || email.isEmpty || senha.isEmpty || confirmar.isEmpty) {
      setState(() => erro = AppLocalizations.of(context)!.field_required);
      return;
    }

    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
      setState(() => erro = AppLocalizations.of(context)!.username_invalid);
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      setState(() => erro = AppLocalizations.of(context)!.invalid_email);
      return;
    }

    if (senha.length < 8) {
      setState(() => erro = AppLocalizations.of(context)!.password_too_short);
      return;
    }

    if (senha != confirmar) {
      setState(() => erro = AppLocalizations.of(context)!.passwords_dont_match);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await AuthIntegrationService.registerWithEmail(
        name: nome,
        username: username,
        email: email,
        password: senha,
        userType: _userType.toLowerCase(),
      );

      if (mounted) {
        setState(() => _isLoading = false);

        if (result['success']) {
          if (result['needsVerification'] == true) {
            // Navegar para tela de verificação
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => EmailVerificationScreen(
                  email: email,
                  userData: result['userData'],
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result['message'] ?? AppLocalizations.of(context)!.account_created),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 5),
              ),
            );
            Navigator.pop(context);
          }
        } else {
          setState(() => erro = result['error']);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          erro = AppLocalizations.of(context)!.connection_error_detail(e.toString());
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark 
        ? const Color(0xFF121212) 
        : const Color(0xFFE6F2FF),
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark 
          ? const Color(0xFF1E1E1E) 
          : tismAqua,
        foregroundColor: Colors.white,
        title: Text(AppLocalizations.of(context)!.register),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.full_name,
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark 
                    ? const Color(0xFF2A2A2A) 
                    : Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.username,
                  prefixText: '@',
                  prefixIcon: const Icon(Icons.alternate_email),
                  hintText: 'exemplo123',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark 
                    ? const Color(0xFF2A2A2A) 
                    : Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.email,
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark 
                    ? const Color(0xFF2A2A2A) 
                    : Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.password,
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark 
                    ? const Color(0xFF2A2A2A) 
                    : Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmarSenhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.confirm_password,
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark 
                    ? const Color(0xFF2A2A2A) 
                    : Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _userType,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.user_type,
                  prefixIcon: const Icon(Icons.work),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark 
                    ? const Color(0xFF2A2A2A) 
                    : Colors.white,
                ),
                dropdownColor: Theme.of(context).brightness == Brightness.dark 
                  ? const Color(0xFF2A2A2A) 
                  : Colors.white,
                items: [
                  DropdownMenuItem(
                    value: 'Participante',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(AppLocalizations.of(context)!.participant),
                        Text(AppLocalizations.of(context)!.participant_desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Responsável',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(AppLocalizations.of(context)!.responsible),
                        Text(AppLocalizations.of(context)!.responsible_desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Profissional',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(AppLocalizations.of(context)!.professional),
                        Text(AppLocalizations.of(context)!.professional_desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
                selectedItemBuilder: (context) => [
                  Text(AppLocalizations.of(context)!.participant),
                  Text(AppLocalizations.of(context)!.responsible),
                  Text(AppLocalizations.of(context)!.professional),
                ],
                onChanged: (value) {
                  setState(() => _userType = value!);
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tismAqua,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isLoading ? null : _registrar,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          AppLocalizations.of(context)!.register,
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
              if (erro != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Text(
                      erro!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
