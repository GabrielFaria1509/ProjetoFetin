import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ImageService {
  static const String _baseUrl = 'https://tism-backend-api-rgxd.onrender.com';
  
  static Future<String?> pickAndCropImage(BuildContext context) async {
    try {
      // Escolher imagem
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image == null) return null;
      
      // Fazer crop quadrado
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Ajustar Foto',
            toolbarColor: const Color(0xFF4FC3F7),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Ajustar Foto',
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: false,
          ),
        ],
      );
      
      if (croppedFile == null) return null;
      
      // Upload para servidor
      return await _uploadImage(croppedFile.path);
      
    } catch (e) {
      debugPrint('Erro ao processar imagem: $e');
      return null;
    }
  }
  
  static Future<String?> _uploadImage(String imagePath) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      
      if (userId == null) return null;
      
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/users/$userId/upload_avatar'),
      );
      
      request.files.add(
        await http.MultipartFile.fromPath('avatar', imagePath),
      );
      
      final response = await request.send();
      
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = json.decode(responseData);
        return data['avatar_url'];
      }
      
      return null;
    } catch (e) {
      debugPrint('Erro no upload: $e');
      return null;
    }
  }
}