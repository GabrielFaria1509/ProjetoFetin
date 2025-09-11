import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/services/user_service.dart';
import 'package:tism/services/theme_service.dart';
import 'package:tism/views/login/login_page.dart';
import 'package:tism/utils/name_formatter.dart';

class ProfilePage extends StatefulWidget {
  final String nomeUsuario;

  const ProfilePage({super.key, required this.nomeUsuario});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userType = 'Responsável';
  String _userName = '';
  String _userUsername = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await UserService.getUser();
    if (user != null && mounted) {
      setState(() {
        _userName = user['name'] ?? user['username'] ?? widget.nomeUsuario;
        _userUsername = user['username'] ?? '';
        _userType = user['userType'] ?? 'Responsável';
      });
      _nameController.text = _userName;
      _usernameController.text = _userUsername;
    }
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar logout'),
        content: const Text('Tem certeza que deseja sair da sua conta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sair'),
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
        title: const Text('Perfil'), 
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
              title: const Text('Nome'),
              subtitle: Text(_userName.isNotEmpty ? _userName : widget.nomeUsuario),
              trailing: const Icon(Icons.edit),
              onTap: _showEditNameDialog,
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: ListTile(
              leading: const Icon(Icons.alternate_email),
              title: const Text('Username'),
              subtitle: Text(_userUsername.isNotEmpty ? '@$_userUsername' : 'Não definido'),
              trailing: const Icon(Icons.edit),
              onTap: _showEditUsernameDialog,
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: ListTile(
              leading: const Icon(Icons.work),
              title: const Text('Tipo de usuário'),
              subtitle: Text(_userType),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: _showUserTypeDialog,
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.palette),
              title: const Text('Tema'),
              subtitle: Consumer<ThemeService>(
                builder: (context, themeService, child) {
                  return Text(themeService.themeName);
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
              child: const Text('Sair do App'),
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
              child: const Text('Deletar Conta'),
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
        title: const Text('Editar Nome'),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Nome completo',
            border: OutlineInputBorder(),
          ),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final inputName = _nameController.text.trim();
              if (inputName.isNotEmpty) {
                // Popup de confirmação
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirmar alteração'),
                    content: Text('Alterar nome para "$inputName"?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Confirmar'),
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
                        const SnackBar(
                          content: Text('Nome atualizado com sucesso!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result['error'] ?? 'Erro ao atualizar nome'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _showUserTypeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selecione seu tipo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Responsável'),
              subtitle: const Text('Pai, mãe ou cuidador'),
              value: 'Responsável',
              groupValue: _userType,
              onChanged: (value) async {
                if (value != null) {
                  final success = await UserService.updateUserType(value);
                  if (success) {
                    setState(() => _userType = value);
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tipo atualizado!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  }
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('Profissional'),
              subtitle: const Text('Educador ou profissional'),
              value: 'Profissional',
              groupValue: _userType,
              onChanged: (value) async {
                if (value != null) {
                  final success = await UserService.updateUserType(value);
                  if (success) {
                    setState(() => _userType = value);
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tipo atualizado!'),
                          backgroundColor: Colors.green,
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
        title: const Text('Selecione o tema'),
        content: Consumer<ThemeService>(
          builder: (context, themeService, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<ThemeMode>(
                  title: const Text('Claro'),
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
                  title: const Text('Escuro'),
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
                  title: const Text('Sistema'),
                  subtitle: const Text('Segue o tema do dispositivo'),
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
        title: const Text('⚠️ DELETAR CONTA'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Esta ação é IRREVERSÍVEL!\n\nTodos os seus dados serão perdidos permanentemente.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Para confirmar, digite exatamente:'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'DELETAR minha conta',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirmController,
              decoration: const InputDecoration(
                labelText: 'Digite a frase acima',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (confirmController.text == 'DELETAR minha conta') {
                Navigator.pop(context, true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Frase incorreta. Verifique maiúsculas e minúsculas.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('DELETAR'),
          ),
        ],
      ),
    );
    
    if (confirm == true) {
      // Implementar delete no UserService
      final user = await UserService.getUser();
      if (user != null) {
        final success = await UserService.deleteAccount(
          email: user['email'],
          password: 'temp', // Backend vai validar por ID
        );
        
        if (success && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Conta deletada com sucesso'),
              backgroundColor: Colors.green,
            ),
          );
          
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
          );
        }
      }
    }
  }

  void _showEditUsernameDialog() {
    _usernameController.text = _userUsername;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Username'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixText: '@',
                border: OutlineInputBorder(),
                hintText: 'exemplo123',
                helperText: 'Apenas letras minúsculas, números e _',
              ),
              onChanged: (value) {
                // Normalizar em tempo real
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
            const Text(
              'Username pode ser alterado apenas 1 vez a cada 3 dias',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final inputUsername = _usernameController.text.trim();
              if (inputUsername.isNotEmpty) {
                // Popup de confirmação
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirmar alteração'),
                    content: Text('Alterar username de @$_userUsername para @${inputUsername.toLowerCase()}?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Confirmar'),
                      ),
                    ],
                  ),
                );
                
                if (confirm == true) {
                  final result = await UserService.updateUsername(inputUsername);
                  if (result['success']) {
                    setState(() => _userUsername = inputUsername.toLowerCase());
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Username atualizado com sucesso!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result['error'] ?? 'Erro ao atualizar username'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}