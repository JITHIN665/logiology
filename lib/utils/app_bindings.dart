import 'package:get/get.dart';
import 'package:logiology/controllers/auth_controller.dart';
import 'package:logiology/controllers/product_controller.dart';
import 'package:logiology/controllers/profile_controller.dart';
import 'package:logiology/services/api_service.dart';
import 'package:logiology/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBindings extends Bindings {
  final SharedPreferences prefs;
  AppBindings(this.prefs);

  @override
  void dependencies() {
    Get.put<AuthService>(AuthService(prefs), permanent: true);
    Get.put<ApiService>(ApiService(), permanent: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<ProductController>(() => ProductController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}
