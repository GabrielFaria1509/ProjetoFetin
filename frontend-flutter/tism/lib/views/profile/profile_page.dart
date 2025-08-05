import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: tismAqua,
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
                backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null
                    ? Icon(Icons.camera_alt, size: 40, color: Colors.grey[600])
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
                leading: const Icon(Icons.person),
                title: const Text('Nome'),
                subtitle: Text(widget.nomeUsuario),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Tipo de usuário
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
            
            // Botão sair
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
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
                onChanged: (value) {
                  setState(() {
                    _userType = value!;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text('Professor'),
                subtitle: const Text('Educador ou profissional'),
                value: 'Professor',
                groupValue: _userType,
                onChanged: (value) {
                  setState(() {
                    _userType = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}