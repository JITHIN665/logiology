import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/utils/app_bindings.dart';
import 'package:logiology/utils/routes.dart';
import 'package:logiology/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Logiology',
      theme: AppTheme.lightTheme,
      initialRoute: Routes.login,
      getPages: AppRoutes.pages,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(), // Add this line
    );
  }
}