import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logiology/models/user_model.dart';

class AuthService extends GetxService {
  final SharedPreferences prefs;
  final Rx<User?> _currentUser = Rx<User?>(null);

  late String correctUsername;
  late String correctPassword;

  ///
  /// loads stored credentials or sets defaults
  ///
  AuthService(this.prefs) {
    correctUsername = prefs.getString('correctUsername') ?? 'admin';
    correctPassword = prefs.getString('correctPassword') ?? 'Pass@123';
    prefs.setString('correctUsername', correctUsername);
    prefs.setString('correctPassword', correctPassword);
    final wasLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (wasLoggedIn) {
      final imagePath = prefs.getString('profileImage');
      _currentUser.value = User(username: correctUsername, password: correctPassword, profileImage: imagePath);
    }
  }

  ///
  /// Returns the currently logged-in user, or null
  ///
  User? get currentUser => _currentUser.value;

  ///
  /// login; returns true on success and persists login state
  ///
  bool login(String username, String password) {
    if (username == correctUsername && password == correctPassword) {
      _currentUser.value = User(username: username, password: password, profileImage: prefs.getString('profileImage'));
      prefs.setBool('isLoggedIn', true);
      return true;
    }
    return false;
  }

  ///
  /// Updates  credentials
  ///
  void updateProfile(String newUsername, String newPassword, String? imagePath) {
    if (_currentUser.value != null) {
      correctUsername = newUsername;
      correctPassword = newPassword;
      prefs.setString('correctUsername', newUsername);
      prefs.setString('correctPassword', newPassword);
      if (imagePath != null) {
        prefs.setString('profileImage', imagePath);
      }
      prefs.setBool('isLoggedIn', true);

      // Update in-memory user
      _currentUser.value = User(username: newUsername, password: newPassword, profileImage: imagePath);
    }
  }

  ///
  /// Clears all saved data
  ///
  void logout() {
    _currentUser.value = null;
    prefs.clear();
  }
}
