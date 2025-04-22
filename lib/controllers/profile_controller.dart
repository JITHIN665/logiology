import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logiology/services/auth_service.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find();
  final ImagePicker _picker = ImagePicker();
  
  final RxString username = ''.obs;
  final RxString password = ''.obs;
  final RxString confirmPassword = ''.obs;
  final RxString profileImagePath = ''.obs;
  final RxBool isEditing = false.obs;

  @override
  void onInit() {
    if (_authService.currentUser != null) {
      username.value = _authService.currentUser!.username;
      profileImagePath.value = _authService.currentUser!.profileImage ?? '';
    }
    super.onInit();
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImagePath.value = image.path;
    }
  }

  void toggleEditing() {
    isEditing.value = !isEditing.value;
    if (!isEditing.value) {
      // Reset if cancel editing
      username.value = _authService.currentUser!.username;
      profileImagePath.value = _authService.currentUser!.profileImage ?? '';
      password.value = '';
      confirmPassword.value = '';
    }
  }

  void saveProfile() {
    if (password.value.isNotEmpty && password.value != confirmPassword.value) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    _authService.updateProfile(
      username.value,
      password.value.isNotEmpty ? password.value : _authService.currentUser!.password,
      profileImagePath.value,
    );
    
    isEditing.value = false;
    Get.snackbar('Success', 'Profile updated');
  }
}