import 'package:get/get.dart';
import 'package:logiology/controllers/auth_controller.dart';
import 'package:logiology/controllers/product_controller.dart';
import 'package:logiology/controllers/profile_controller.dart';
import 'package:logiology/services/api_service.dart';
import 'package:logiology/services/auth_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Initialize services
    Get.put(AuthService(), permanent: true);
    Get.put(ApiService(), permanent: true);
    
    // Initialize controllers
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => ProductController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}