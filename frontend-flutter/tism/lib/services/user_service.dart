import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String _keyUsername = 'username';
  static const String _keyUserType = 'user_type';
  static const String _keyProfileImage = 'profile_image';
  static const String _keyIsLoggedIn = 'is_logged_in';

  static Future<void> saveUser({
    required String username,
    String userType = 'Responsável',
    String? profileImagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyUserType, userType);
    await prefs.setBool(_keyIsLoggedIn, true);
    if (profileImagePath != null) {
      await prefs.setString(_keyProfileImage, profileImagePath);
    }
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(_keyIsLoggedIn) ?? false;
    
    if (!isLoggedIn) return null;
    
    return {
      'username': prefs.getString(_keyUsername) ?? '',
      'userType': prefs.getString(_keyUserType) ?? 'Responsável',
      'profileImagePath': prefs.getString(_keyProfileImage),
      'isLoggedIn': isLoggedIn,
    };
  }

  static Future<void> updateUserType(String userType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserType, userType);
  }

  static Future<void> updateProfileImage(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyProfileImage, imagePath);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }
}