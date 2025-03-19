import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<void> saveFavorites(List<String> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', favorites);
  }

  static Future<List<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }

  static Future<void> saveBannedWords(List<String> bannedWords) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('bannedWords', bannedWords);
  }

  static Future<List<String>> loadBannedWords() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('bannedWords') ?? [];
  }

  static Future<void> saveFabPosition(double x, double y) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fabX', x);
    await prefs.setDouble('fabY', y);
  }

  static Future<List<double>> loadFabPosition() async {
    final prefs = await SharedPreferences.getInstance();
    return [
      prefs.getDouble('fabX') ?? 10.0,
      prefs.getDouble('fabY') ?? 500.0,
    ];
  }

  static Future<void> saveThemeHue(double hue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('themeHue', hue);
  }

  static Future<double> loadThemeHue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('themeHue') ?? 0.0;
  }

  static Future<void> saveLoginStatus(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }
}
