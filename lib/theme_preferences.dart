import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const String _themeIndexKey = 'themeIndex';

  // Save the selected theme index
  static Future<void> saveThemeIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeIndexKey, index); // This will overwrite the old value
  }

  // Load the saved theme index
  static Future<int> loadThemeIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_themeIndexKey) ?? 0; // Default to 0 if not set
  }
}
