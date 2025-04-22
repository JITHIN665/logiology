import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/utils/app_bindings.dart';
import 'package:logiology/utils/routes.dart';
import 'package:logiology/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Logiology',
      theme: AppTheme.lightTheme,
      initialRoute: Routes.splash,
      getPages: AppRoutes.pages,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(prefs),
    );
  }
}
