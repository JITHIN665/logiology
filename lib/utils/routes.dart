import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:logiology/views/auth/login_screen.dart';
import 'package:logiology/views/home/product_detail_screen.dart';
import 'package:logiology/views/home/product_list_screen.dart';
import 'package:logiology/views/profile/profile_screen.dart';

class Routes {
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String productDetail = '/product-detail';
}

class AppRoutes {
  static final pages = [
    GetPage(name: Routes.login, page: () => LoginScreen()),
    GetPage(name: Routes.home, page: () => ProductListScreen()),
    GetPage(name: Routes.profile, page: () => ProfileScreen()),
    GetPage(name: Routes.productDetail, page: () => ProductDetailScreen()),
  ];
}