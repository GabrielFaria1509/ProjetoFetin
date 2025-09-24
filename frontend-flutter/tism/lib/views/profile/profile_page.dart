import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/services/user_service.dart';
import 'package:tism/services/theme_service.dart';
import 'package:tism/l10n/app_localizations.dart';
import 'package:tism/views/login/login_page.dart';


class ProfilePage extends StatefulWidget {
  final String nomeUsuario;

  const ProfilePage({super.key, required this.nomeUsuario});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userType = 'Participante';
  String _userName = '';
  String _userUsername = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  String _capitalizeUserType(String userType) {
    switch (userType.toLowerCase()) {
      case 'participante':
        return 'Participante';
      case 'responsavel':
      case 'responsável':
        return 'Responsável';
      case 'profissional':
        return 'Profissional';
      default:
        return 'Participante';
    }
  }

  String _translateUserType(String userType) {
    final l10n = AppLocalizations.of(context)!;
    switch (userType) {
      case 'Participante':
        return l10n.participant;
      case 'Responsável':
        return l10n.responsible;
      case 'Profissional':
        return l10n.professional;
      default:
        return l10n.participant;
    }
  }

  Future<void> _loadUserData() async {
    final user = await UserService.getUser();
    if (user != null && mounted) {
      setState(() {
        _userName = user['name'] ?? user['username'] ?? widget.nomeUsuario;
        _userUsername = user['username'] ?? '';
        final userTypeRaw = (user['userType'] ?? 'participante').toLowerCase();
        _userType = _capitalizeUserType(userTypeRaw);
      });
      _nameController.text = _userName;
      _usernameController.text = _userUsername;
    }
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.logout),
        content: Text(AppLocalizations.of(context)!.logout_confirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context)!.logout),
          ),
        ],
      ),
    );
    
    if (confirm == true) {
      await UserService.logout();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profile), 
        backgroundColor: tismAqua,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
        children: [
          const SizedBox(height: 20),
          
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person, size: 60, color: Colors.white),
          ),
          
          const SizedBox(height: 30),

          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(AppLocalizations.of(context)!.name),
              subtitle: Text(_userName.isNotEmpty ? _userName : widget.nomeUsuario),
              trailing: const Icon(Icons.edit),
              onTap: _showEditNameDialog,
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: ListTile(
              leading: const Icon(Icons.alternate_email),
              title: Text(AppLocalizations.of(context)!.username),
              subtitle: Text(_userUsername.isNotEmpty ? '@$_userUsername' : AppLocalizations.of(context)!.not_defined),
              trailing: const Icon(Icons.edit),
              onTap: _showEditUsernameDialog,
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: ListTile(
              leading: const Icon(Icons.work),
              title: Text(AppLocalizations.of(context)!.user_type),
              subtitle: Text(_translateUserType(_userType)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: _showUserTypeDialog,
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.palette),
              title: Text(AppLocalizations.of(context)!.theme),
              subtitle: Consumer<ThemeService>(
                builder: (context, themeService, child) {
                  final l10n = AppLocalizations.of(context)!;
                  switch (themeService.themeMode) {
                    case ThemeMode.light:
                      return Text(l10n.theme_light);
                    case ThemeMode.dark:
                      return Text(l10n.theme_dark);
                    case ThemeMode.system:
                      return Text(l10n.theme_system);
                  }
                },
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: _showThemeDialog,
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _logout,
              child: Text(AppLocalizations.of(context)!.logout),
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _deleteAccount,
              child: Text(AppLocalizations.of(context)!.delete_account),
            ),
          ),
        ],
      ),
      ),
    );
  }
  
  void _showEditNameDialog() {
    _nameController.text = _userName.isNotEmpty ? _userName : widget.nomeUsuario;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.edit_name),
        content: TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.full_name,
            border: const OutlineInputBorder(),
          ),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () async {
              final inputName = _nameController.text.trim();
              if (inputName.isNotEmpty) {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(AppLocalizations.of(context)!.confirm_change),
                    content: Text(AppLocalizations.of(context)!.change_name_to(inputName)),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(AppLocalizations.of(context)!.cancel),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(AppLocalizations.of(context)!.confirm),
                      ),
                    ],
                  ),
                );
                
                if (confirm == true) {
                  final result = await UserService.updateName(inputName);
                  if (result['success']) {
                    setState(() => _userName = inputName);
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalizations.of(context)!.name_updated),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result['error'] ?? AppLocalizations.of(context)!.error_updating_name),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
              }
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }

  void _showUserTypeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.select_user_type),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: Text(AppLocalizations.of(context)!.participant),
              value: 'Participante',
              groupValue: _userType,
              onChanged: (value) async {
                if (value != null) {
                  final result = await UserService.updateUserType(value);
                  if (result['success']) {
                    setState(() => _userType = value);
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalizations.of(context)!.type_updated),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result['error'] ?? AppLocalizations.of(context)!.error_updating_type),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
              },
            ),
            RadioListTile<String>(
              title: Text(AppLocalizations.of(context)!.responsible),
              value: 'Responsável',
              groupValue: _userType,
              onChanged: (value) async {
                if (value != null) {
                  final result = await UserService.updateUserType(value);
                  if (result['success']) {
                    setState(() => _userType = value);
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalizations.of(context)!.type_updated),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result['error'] ?? AppLocalizations.of(context)!.error_updating_type),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
              },
            ),
            RadioListTile<String>(
              title: Text(AppLocalizations.of(context)!.professional),
              value: 'Profissional',
              groupValue: _userType,
              onChanged: (value) async {
                if (value != null) {
                  final result = await UserService.updateUserType(value);
                  if (result['success']) {
                    setState(() => _userType = value);
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalizations.of(context)!.type_updated),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result['error'] ?? AppLocalizations.of(context)!.error_updating_type),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.theme),
        content: Consumer<ThemeService>(
          builder: (context, themeService, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<ThemeMode>(
                  title: Text(AppLocalizations.of(context)!.light_theme),
                  value: ThemeMode.light,
                  groupValue: themeService.themeMode,
                  onChanged: (value) async {
                    if (value != null) {
                      await themeService.setThemeMode(value);
                      if (context.mounted) Navigator.pop(context);
                    }
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: Text(AppLocalizations.of(context)!.dark_theme),
                  value: ThemeMode.dark,
                  groupValue: themeService.themeMode,
                  onChanged: (value) async {
                    if (value != null) {
                      await themeService.setThemeMode(value);
                      if (context.mounted) Navigator.pop(context);
                    }
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: Text(AppLocalizations.of(context)!.system_theme),
                  subtitle: Text(AppLocalizations.of(context)!.system_theme_desc),
                  value: ThemeMode.system,
                  groupValue: themeService.themeMode,
                  onChanged: (value) async {
                    if (value != null) {
                      await themeService.setThemeMode(value);
                      if (context.mounted) Navigator.pop(context);
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _deleteAccount() async {
    final TextEditingController confirmController = TextEditingController();
    
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.delete_account),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.delete_warning,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.delete_confirmation),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                AppLocalizations.of(context)!.delete_phrase,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirmController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.delete_input_hint,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              if (confirmController.text == 'DELETAR minha conta') {
                Navigator.pop(context, true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.delete_incorrect),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      ),
    );
    
    if (confirm == true) {
      final user = await UserService.getUser();
      if (user != null) {
        final passwordController = TextEditingController();
        final password = await showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.confirm_password_title),
            content: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.enter_password,
                border: const OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, passwordController.text),
                child: Text(AppLocalizations.of(context)!.confirm),
              ),
            ],
          ),
        );
        
        if (password == null || password.isEmpty) return;
        
        final result = await UserService.deleteAccount(
          email: user['email'] ?? '',
          password: password,
        );
        
        if (mounted) {
          if (result['success']) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result['message'] ?? AppLocalizations.of(context)!.account_deleted_success),
                  backgroundColor: Colors.green,
                ),
              );
              
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            }
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result['error'] ?? AppLocalizations.of(context)!.error_deleting_account),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        }
      }
    }
  }

  void _showEditUsernameDialog() {
    _usernameController.text = _userUsername;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.edit_username_title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.username,
                prefixText: '@',
                border: const OutlineInputBorder(),
                hintText: AppLocalizations.of(context)!.example123,
                helperText: AppLocalizations.of(context)!.username_help,
              ),
              onChanged: (value) {
                final normalized = value.toLowerCase().replaceAll(RegExp(r'[^a-z0-9_]'), '');
                if (normalized != value) {
                  _usernameController.value = _usernameController.value.copyWith(
                    text: normalized,
                    selection: TextSelection.collapsed(offset: normalized.length),
                  );
                }
              },
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.username_cooldown_info,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () async {
              final inputUsername = _usernameController.text.trim();
              if (inputUsername.isNotEmpty) {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(AppLocalizations.of(context)!.confirm_change),
                    content: Text(AppLocalizations.of(context)!.change_username_to(_userUsername, inputUsername.toLowerCase())),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(AppLocalizations.of(context)!.cancel),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(AppLocalizations.of(context)!.confirm),
                      ),
                    ],
                  ),
                );
                
                if (confirm == true) {
                  final result = await UserService.updateUsername(inputUsername);
                  if (mounted) {
                    if (result['success']) {
                      setState(() => _userUsername = inputUsername.toLowerCase());
                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppLocalizations.of(context)!.username_updated),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result['error'] ?? AppLocalizations.of(context)!.error_updating_username),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  }
                }
              }
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }
}