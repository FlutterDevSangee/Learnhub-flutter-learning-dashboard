import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnhub/screens/dashboard/dashboard.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  void togglePassword() {
    isPasswordVisible.toggle();
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must contain at least 6 characters';
    }

    return null;
  }

  Future<void> login() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      // Mock API delay
      await Future.delayed(const Duration(seconds: 2));

      final email = emailController.text.trim();
      final password = passwordController.text;

      if (email == 'test@example.com' && password == 'password123') {
        Get.offAll(() => DashboardView());
      } else {
        Get.snackbar(
          'Login Failed',
          'Invalid email or password',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
          borderRadius: 14,
          backgroundColor: const Color(0xFFFFEEEE),
          colorText: const Color(0xFFC62828),
          icon: const Icon(
            Icons.error_outline_rounded,
            color: Color(0xFFC62828),
          ),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Something went wrong',
        'Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
