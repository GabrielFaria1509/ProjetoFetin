import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImageService {
  static String get _baseUrl => dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';
  
  static Future<String?> pickAndCropImage(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      
      if (image == null) return null;
      
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Ajustar Foto',
            toolbarColor: const Color(0xFF4FC3F7),
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Ajustar Foto',
            aspectRatioLockEnabled: true,
          ),
        ],
      );
      
      if (croppedFile == null) return null;
      
      return await _uploadImage(croppedFile.path);
      
    } catch (e) {
      return null;
    }
  }
  
  static Future<String?> _uploadImage(String imagePath) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      
      if (userId == null) return null;
      
      final bytes = await File(imagePath).readAsBytes();
      final base64Image = base64Encode(bytes);
      
      final response = await http.post(
        Uri.parse('$_baseUrl/users/$userId/upload_avatar'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'avatar_base64': base64Image}),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['avatar_url'];
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }
}