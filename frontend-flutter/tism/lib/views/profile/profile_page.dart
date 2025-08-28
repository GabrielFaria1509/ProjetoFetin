import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tism/services/user_service.dart';
import 'package:tism/views/login/login_page.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  final String nomeUsuario;

  const ProfilePage({super.key, required this.nomeUsuario});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  String _userType = 'Responsável';
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await UserService.getUser();
    if (user != null) {
      setState(() {
        _userType = user['userType'];
        if (user['profileImagePath'] != null) {
          _profileImage = File(user['profileImagePath']);
        }
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
      await UserService.updateProfileImage(image.path);
    }
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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Foto de perfil
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : null,
                child: _profileImage == null
                    ? Icon(
                        Icons.camera_alt, 
                        size: 40, 
                        color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.grey[300] 
                          : Colors.grey[600]
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Toque para alterar foto',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 30),

            // Nome do usuário
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.white 
                    : null,
                ),
                title: const Text('Nome'),
                subtitle: Text(widget.nomeUsuario),
              ),
            ),

            const SizedBox(height: 16),

            // Tipo de usuário
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.work,
                  color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.white 
                    : null,
                ),
                title: const Text('Tipo de usuário'),
                subtitle: Text(_userType),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.white 
                    : null,
                ),
                onTap: _showUserTypeDialog,
              ),
            ),

            const SizedBox(height: 30),

            // Botão sair
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

  void _showUserTypeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
                    setState(() {
                      _userType = value;
                    });
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
                    setState(() {
                      _userType = value;
                    });
                    await UserService.updateUserType(value);
                    if (context.mounted) Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
