import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/controllers/auth_controller.dart';
import 'package:logiology/views/widgets/custom_button.dart';
import 'package:logiology/views/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(size: 100),
            const SizedBox(height: 30),
            CustomTextField(controller: usernameController, labelText: 'Username', prefixIcon: Icons.person),
            const SizedBox(height: 16),
            CustomTextField(controller: passwordController, labelText: 'Password', prefixIcon: Icons.lock, obscureText: true),
            const SizedBox(height: 24),
            Obx(
              () => CustomButton(
                onPressed:
                    authController.isLoading.value
                        ? null
                        : () {
                          authController.login(usernameController.text.trim(), passwordController.text.trim());
                        },
                child:
                    authController.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Login', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
