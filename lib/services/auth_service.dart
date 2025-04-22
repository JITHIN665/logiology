import 'package:get/get.dart';
import 'package:logiology/models/user_model.dart';

class AuthService extends GetxService {
  final Rx<User?> _currentUser = Rx<User?>(null);

  User? get currentUser => _currentUser.value;

  bool login(String username, String password) {
    if (username == 'admin' && password == 'Pass@123') {
      _currentUser.value = User(username: username, password: password);
      return true;
    }
    return false;
  }

  void updateProfile(String newUsername, String newPassword, String? imagePath) {
    if (_currentUser.value != null) {
      _currentUser.value = User(
        username: newUsername,
        password: newPassword,
        profileImage: imagePath,
      );
    }
  }

  void logout() {
    _currentUser.value = null;
  }
}