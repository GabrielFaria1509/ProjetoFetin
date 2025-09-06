import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:tism/services/user_service.dart';
import 'package:tism/views/login/login_page.dart';
import 'package:tism/utils/name_formatter.dart';
import 'package:permission_handler/permission_handler.dart';
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
  String _userName = '';
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await UserService.getUser();
      if (user != null && mounted) {
        setState(() {
          _userName = user['username'] ?? widget.nomeUsuario;
          _userType = user['userType'] ?? 'Responsável';
          if (user['profileImagePath'] != null) {
            final imageFile = File(user['profileImagePath']);
            if (imageFile.existsSync()) {
              _profileImage = imageFile;
            }
          }
        });
        _nameController.text = _userName;
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _userName = widget.nomeUsuario;
          _userType = 'Responsável';
        });
        _nameController.text = _userName;
      }
    }
  }

  Future<bool> _requestPermissions() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<void> _pickImage() async {
    try {
      // Solicitar permissões primeiro
      if (!await _requestPermissions()) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Permissão de armazenamento necessária'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }
      
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image != null && mounted) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          maxWidth: 512,
          maxHeight: 512,
          compressQuality: 85,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Editar Foto',
              toolbarColor: tismAqua,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
              hideBottomControls: false,
              showCropGrid: true,
            ),
            IOSUiSettings(
              title: 'Editar Foto',
              doneButtonTitle: 'Concluir',
              cancelButtonTitle: 'Cancelar',
            ),
          ],
        );
        
        if (croppedFile != null && mounted) {
          setState(() {
            _profileImage = File(croppedFile.path);
          });
          await UserService.updateProfileImage(croppedFile.path);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao selecionar imagem: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
          children: [
            const SizedBox(height: 20),
            // Foto de perfil
            GestureDetector(
              onTap: _profileImage == null ? _pickImage : _showImageOptions,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                backgroundImage: _profileImage != null && _profileImage!.existsSync()
                    ? FileImage(_profileImage!)
                    : null,
                child: _profileImage == null || !_profileImage!.existsSync()
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
              _profileImage == null ? 'Toque para adicionar foto' : 'Toque para alterar/remover',
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
                subtitle: Text(_userName.isNotEmpty ? _userName : widget.nomeUsuario),
                trailing: Icon(
                  Icons.edit,
                  color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.white 
                    : null,
                ),
                onTap: _showEditNameDialog,
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
                setState(() {
                  _userName = newName;
                });
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

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tirar foto'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Escolher da galeria'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
              if (_profileImage != null && _profileImage!.existsSync())
                ListTile(
                  leading: const Icon(Icons.crop),
                  title: const Text('Editar foto atual'),
                  onTap: () {
                    Navigator.pop(context);
                    _cropCurrentImage();
                  },
                ),
              if (_profileImage != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Remover foto', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    _removeImage();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImageFromCamera() async {
    try {
      // Solicitar permissões de câmera
      final cameraStatus = await Permission.camera.request();
      if (!cameraStatus.isGranted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Permissão de câmera necessária'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }
      
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image != null && mounted) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          maxWidth: 512,
          maxHeight: 512,
          compressQuality: 85,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Editar Foto',
              toolbarColor: tismAqua,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
              hideBottomControls: false,
              showCropGrid: true,
            ),
            IOSUiSettings(
              title: 'Editar Foto',
              doneButtonTitle: 'Concluir',
              cancelButtonTitle: 'Cancelar',
            ),
          ],
        );
        
        if (croppedFile != null && mounted) {
          setState(() {
            _profileImage = File(croppedFile.path);
          });
          await UserService.updateProfileImage(croppedFile.path);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao tirar foto: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _removeImage() async {
    setState(() {
      _profileImage = null;
    });
    await UserService.updateProfileImage(null);
  }
  
  Future<void> _cropCurrentImage() async {
    if (_profileImage == null || !_profileImage!.existsSync()) return;
    
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _profileImage!.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        maxWidth: 512,
        maxHeight: 512,
        compressQuality: 85,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Editar Foto',
            toolbarColor: tismAqua,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls: false,
            showCropGrid: true,
          ),
          IOSUiSettings(
            title: 'Editar Foto',
            doneButtonTitle: 'Concluir',
            cancelButtonTitle: 'Cancelar',
          ),
        ],
      );
      
      if (croppedFile != null && mounted) {
        setState(() {
          _profileImage = File(croppedFile.path);
        });
        await UserService.updateProfileImage(croppedFile.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao editar imagem: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
