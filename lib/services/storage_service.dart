import 'package:cloud_firestore/cloud_firestore.dart';

class StorageService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save favorites to Firestore
  static Future<void> saveFavorites(String userId, List<String> favorites) async {
    await _firestore.collection('users').doc(userId).set({
      'favorites': favorites,
    }, SetOptions(merge: true));
  }

  // Load favorites from Firestore
  static Future<List<String>> loadFavorites(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return List<String>.from(doc.data()?['favorites'] ?? []);
  }

  // Save banned words to Firestore
  static Future<void> saveBannedWords(String userId, List<String> bannedWords) async {
    await _firestore.collection('users').doc(userId).set({
      'bannedWords': bannedWords,
    }, SetOptions(merge: true));
  }

  // Load banned words from Firestore
  static Future<List<String>> loadBannedWords(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return List<String>.from(doc.data()?['bannedWords'] ?? []);
  }

  // Save FAB position to Firestore
  static Future<void> saveFabPosition(String userId, double x, double y) async {
    await _firestore.collection('users').doc(userId).set({
      'fabPosition': {'x': x, 'y': y},
    }, SetOptions(merge: true));
  }

  // Load FAB position from Firestore
  static Future<List<double>> loadFabPosition(String userId) async {
    if (userId == null || userId.isEmpty) {
      throw ArgumentError('Document path must not be empty');
    }
    final doc = await _firestore.collection('users').doc(userId).get();
    final position = doc.data()?['fabPosition'] ?? {'x': 10.0, 'y': 500.0};
    return [position['x'], position['y']];
  }

  // Save theme hue to Firestore
  static Future<void> saveThemeHue(String userId, double hue) async {
    await _firestore.collection('users').doc(userId).set({
      'themeHue': hue,
    }, SetOptions(merge: true));
  }

  // Load theme hue from Firestore
  static Future<double> loadThemeHue(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return doc.data()?['themeHue'] ?? 0.0;
  }

  // Save login status to Firestore
  static Future<void> saveLoginStatus(String userId, bool isLoggedIn) async {
    await _firestore.collection('users').doc(userId).set({
      'isLoggedIn': isLoggedIn,
    }, SetOptions(merge: true));
  }

  // Check login status from Firestore
  static Future<bool> isUserLoggedIn(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return doc.data()?['isLoggedIn'] ?? false;
  }

  // Logout user
  static Future<void> logout(String userId) async {
    await _firestore.collection('users').doc(userId).set({
      'isLoggedIn': false,
    }, SetOptions(merge: true));
  }
}