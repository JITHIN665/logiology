import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/controllers/auth_controller.dart';
import 'package:logiology/controllers/profile_controller.dart';
import 'package:logiology/views/widgets/custom_button.dart';
import 'package:logiology/views/widgets/custom_textfield.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController _profileController = Get.put(ProfileController());
  final AuthController _authController = Get.find();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          Obx(() => IconButton(
                icon: Icon(_profileController.isEditing.value ? Icons.close : Icons.edit),
                onPressed: _profileController.toggleEditing,
              )),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: _profileController.profileImagePath.isNotEmpty
                          ? FileImage(File(_profileController.profileImagePath.value))
                          : const AssetImage('assets/default_profile.png') as ImageProvider,
                    ),
                    if (_profileController.isEditing.value)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.blue),
                          onPressed: _profileController.pickImage,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'Username',
                initialValue: _profileController.username.value,
                enabled: _profileController.isEditing.value,
                onChanged: (value) => _profileController.username.value = value,
              ),
              const SizedBox(height: 16),
              if (_profileController.isEditing.value) ...[
                CustomTextField(
                  labelText: 'New Password',
                  obscureText: true,
                  onChanged: (value) => _profileController.password.value = value,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: 'Confirm Password',
                  obscureText: true,
                  onChanged: (value) => _profileController.confirmPassword.value = value,
                ),
                const SizedBox(height: 24),
                CustomButton(
                  onPressed: _profileController.saveProfile,
                  child: const Text('Save Changes'),
                ),
              ],
              const SizedBox(height: 20),
              CustomButton(
                onPressed: _authController.logout,
                child: const Text('Logout'),
              ),
            ],
          );
        }),
      ),
    );
  }
}