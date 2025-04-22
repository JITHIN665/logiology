import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logiology/services/auth_service.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final ImagePicker _picker = ImagePicker();

  final RxString username = ''.obs;
  final RxString password = ''.obs;
  final RxString confirmPassword = ''.obs;
  final RxString profileImagePath = ''.obs;
  final RxBool isEditing = false.obs;

  @override
  void onInit() {
    super.onInit();
    final user = _authService.currentUser;
    if (user != null) {
      username.value = user.username;
      profileImagePath.value = user.profileImage ?? '';
    }
  }

  ///
  /// Pick an image from gallery
  ///
  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImagePath.value = image.path;
    }
  }

  ///
  /// Capture a new photo using camera
  ///
  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      profileImagePath.value = image.path;
    }
  }

  ///
  /// Save changes
  ///
  Future<void> saveProfile() async {
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
