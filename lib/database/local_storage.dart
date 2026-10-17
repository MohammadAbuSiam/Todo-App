import 'package:shared_preferences/shared_preferences.dart';

/// Stores the user's name locally (SharedPreferences).
class LocalStorage {
  static const _nameKey = 'user_name';

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_nameKey);
    return (name == null || name.trim().isEmpty) ? null : name;
  }

  Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name.trim());
  }
}
