import 'package:get/get.dart';
import 'package:logiology/services/auth_service.dart';
import 'package:logiology/utils/routes.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find();
  final RxBool isLoading = false.obs;

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    
    if (_authService.login(username, password)) {
      Get.offAllNamed(Routes.home);
    } else {
      Get.snackbar('Error', 'Invalid credentials');
    }
    
    isLoading.value = false;
  }

  void logout() {
    _authService.logout();
    Get.offAllNamed(Routes.login);
  }
}