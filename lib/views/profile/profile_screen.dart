import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/controllers/auth_controller.dart';
import 'package:logiology/controllers/profile_controller.dart';
import 'package:logiology/views/widgets/custom_button.dart';
import 'package:logiology/views/widgets/custom_textfield.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController _profileController = Get.find();
  final AuthController _authController = Get.find();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
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
                      backgroundImage:
                          _profileController.profileImagePath.isNotEmpty
                              ? FileImage(File(_profileController.profileImagePath.value))
                              : const AssetImage('assets/icon/no_profile_picture_icon.png') as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.blue),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder:
                                (_) => SafeArea(
                                  child: Wrap(
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.camera_alt),
                                        title: const Text('Camera'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _profileController.pickImageFromCamera();
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.photo_library),
                                        title: const Text('Gallery'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _profileController.pickImageFromGallery();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'Username',
                initialValue: _profileController.username.value,
                onChanged: (val) => _profileController.username.value = val,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Password',
                obscureText: true,
                initialValue: '',
                onChanged: (val) => _profileController.password.value = val,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Confirm Password',
                obscureText: true,
                initialValue: '',
                onChanged: (val) => _profileController.confirmPassword.value = val,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  onPressed: _profileController.saveProfile,
                  child: const Text('Save Changes', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  backgroundColor: Colors.red,
                  onPressed: _authController.logout,
                  child: const Text('Logout', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
