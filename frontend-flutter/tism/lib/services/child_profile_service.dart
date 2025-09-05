import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../views/routine/routine_models.dart';

class ChildProfileService {
  static const String _keyProfiles = 'child_profiles';
  static const String _keyActiveProfile = 'active_profile_id';

  static Future<List<ChildProfile>> getProfiles() async {
    final prefs = await SharedPreferences.getInstance();
    final profilesJson = prefs.getStringList(_keyProfiles) ?? [];
    
    return profilesJson.map((json) {
      final data = jsonDecode(json);
      return ChildProfile(
        name: data['name'],
        ageDisplay: data['ageDisplay'],
        ageInMonths: data['ageInMonths'],
        supportLevel: data['supportLevel'],
        sensoryPreferences: List<String>.from(data['sensoryPreferences']),
        interests: List<String>.from(data['interests']),
      );
    }).toList();
  }

  static Future<void> saveProfile(ChildProfile profile) async {
    final profiles = await getProfiles();
    
    // Remove perfil existente com mesmo nome
    profiles.removeWhere((p) => p.name == profile.name);
    profiles.add(profile);
    
    await _saveProfiles(profiles);
    
    // Se for o primeiro perfil, torna ativo
    if (profiles.length == 1) {
      await setActiveProfile(profile.name);
    }
  }

  static Future<void> deleteProfile(String name) async {
    final profiles = await getProfiles();
    profiles.removeWhere((p) => p.name == name);
    await _saveProfiles(profiles);
    
    // Se deletou o perfil ativo, define outro como ativo
    final activeProfile = await getActiveProfile();
    if (activeProfile?.name == name && profiles.isNotEmpty) {
      await setActiveProfile(profiles.first.name);
    }
  }

  static Future<void> _saveProfiles(List<ChildProfile> profiles) async {
    final prefs = await SharedPreferences.getInstance();
    final profilesJson = profiles.map((profile) => jsonEncode({
      'name': profile.name,
      'ageDisplay': profile.ageDisplay,
      'ageInMonths': profile.ageInMonths,
      'supportLevel': profile.supportLevel,
      'sensoryPreferences': profile.sensoryPreferences,
      'interests': profile.interests,
    })).toList();
    
    await prefs.setStringList(_keyProfiles, profilesJson);
  }

  static Future<ChildProfile?> getActiveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final activeProfileName = prefs.getString(_keyActiveProfile);
    
    if (activeProfileName == null) return null;
    
    final profiles = await getProfiles();
    try {
      return profiles.firstWhere((p) => p.name == activeProfileName);
    } catch (e) {
      return profiles.isNotEmpty ? profiles.first : null;
    }
  }

  static Future<void> setActiveProfile(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyActiveProfile, name);
  }
}