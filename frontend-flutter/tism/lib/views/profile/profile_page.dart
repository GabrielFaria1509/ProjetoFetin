import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:tism/services/user_service.dart';
import 'package:tism/services/image_service.dart';
import 'package:tism/views/login/login_page.dart';
import 'package:tism/utils/name_formatter.dart';
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  final String nomeUsuario;

  const ProfilePage({super.key, required this.nomeUsuario});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _profileImageUrl;
  String _userType = 'Responsável';
  String _userName = '';
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await UserService.getUser();
    if (user != null && mounted) {
      setState(() {
        _userName = user['username'] ?? widget.nomeUsuario;
        _userType = user['userType'] ?? 'Responsável';
        _profileImageUrl = user['profileImagePath'];
      });
      _nameController.text = _userName;
    }
  }

  Future<void> _pickImage() async {
    setState(() => _isLoading = true);
    
    final avatarUrl = await ImageService.pickAndCropImage(context);
    
    if (avatarUrl != null) {
      setState(() => _profileImageUrl = avatarUrl);
      await UserService.updateProfileImage(avatarUrl);
    }
    
    setState(() => _isLoading = false);
  }

  Future<void> _logout() async {
    await UserService.logout();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
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
          GestureDetector(
            onTap: _isLoading ? null : _pickImage,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _profileImageUrl != null 
                      ? _getImageProvider(_profileImageUrl!)
                      : null,
                  child: _profileImageUrl == null
                      ? const Icon(Icons.camera_alt, size: 40)
                      : null,
                ),
                if (_isLoading)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Toque para ${_profileImageUrl == null ? 'adicionar' : 'alterar'} foto',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
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
              leading: const Icon(Icons.work),
              title: const Text('Tipo de usuário'),
              subtitle: Text(_userType),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: _showUserTypeDialog,
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _logout,
              child: const Text('Sair do App'),
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
                final newName = NameFormatter.formatName(inputName);
                setState(() => _userName = newName);
                await UserService.updateUsername(newName);
                if (context.mounted) Navigator.pop(context);
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
                  setState(() => _userType = value);
                  await UserService.updateUserType(value);
                  if (context.mounted) Navigator.pop(context);
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('Professor'),
              subtitle: const Text('Educador ou profissional'),
              value: 'Professor',
              groupValue: _userType,
              onChanged: (value) async {
                if (value != null) {
                  setState(() => _userType = value);
                  await UserService.updateUserType(value);
                  if (context.mounted) Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  
  ImageProvider? _getImageProvider(String imageUrl) {
    if (imageUrl.startsWith('data:image')) {
      final base64String = imageUrl.split(',')[1];
      final bytes = base64Decode(base64String);
      return MemoryImage(bytes);
    } else {
      return NetworkImage(imageUrl);
    }
  }
}