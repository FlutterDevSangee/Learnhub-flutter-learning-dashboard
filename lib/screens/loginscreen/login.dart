import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnhub/controllers/logincontroller/logincontlr.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final loginCntrl = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ─────────────────────────────────────────────
              // Header
              // ─────────────────────────────────────────────
              Container(
                width: double.infinity,
                height: size.height * 0.36,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF5146E5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Stack(
                  children: [
                    // Decorative circles
                    Positioned(
                      top: -50,
                      right: -40,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.08),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: -60,
                      left: -40,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.06),
                        ),
                      ),
                    ),

                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo
                          Container(
                            width: 76,
                            height: 76,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  blurRadius: 25,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.school_rounded,
                              size: 42,
                              color: Color(0xFF6C63FF),
                            ),
                          ),

                          const SizedBox(height: 18),

                          const Text(
                            'LearnHub',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            'Learn. Grow. Succeed.',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ─────────────────────────────────────────────
              // Login Card
              // ─────────────────────────────────────────────
              Transform.translate(
                offset: const Offset(0, -25),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 30,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Form(
                    key: loginCntrl.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome back 👋',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF181A20),
                          ),
                        ),

                        const SizedBox(height: 7),

                        const Text(
                          'Sign in to continue your learning journey.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF7A7F8C),
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Email
                        const Text(
                          'Email address',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333640),
                          ),
                        ),

                        const SizedBox(height: 9),

                        TextFormField(
                          controller: loginCntrl.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: loginCntrl.validateEmail,
                          decoration: _inputDecoration(
                            hintText: 'Enter your email',
                            icon: Icons.email_outlined,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Password
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333640),
                          ),
                        ),

                        const SizedBox(height: 9),

                        Obx(
                          () => TextFormField(
                            controller: loginCntrl.passwordController,
                            obscureText: !loginCntrl.isPasswordVisible.value,
                            textInputAction: TextInputAction.done,
                            validator: loginCntrl.validatePassword,
                            onFieldSubmitted: (_) {
                              loginCntrl.login();
                            },
                            decoration: _inputDecoration(
                              hintText: 'Enter your password',
                              icon: Icons.lock_outline_rounded,
                              suffixIcon: IconButton(
                                onPressed: loginCntrl.togglePassword,
                                icon: Icon(
                                  loginCntrl.isPasswordVisible.value
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: const Color(0xFF8B8F9B),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Forgot password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: Color(0xFF6C63FF),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        // Login Button
                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: loginCntrl.isLoading.value
                                  ? null
                                  : loginCntrl.login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6C63FF),
                                disabledBackgroundColor: const Color(
                                  0xFFB9B5F5,
                                ),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17),
                                ),
                              ),
                              child: loginCntrl.isLoading.value
                                  ? const SizedBox(
                                      height: 23,
                                      width: 23,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Sign In',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 25,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'New to LearnHub?',
                                style: TextStyle(
                                  color: Color(0xFF8A8E99),
                                  fontSize: 13,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Create account',
                                  style: TextStyle(
                                    color: Color(0xFF6C63FF),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Color(0xFFB0B3BC), fontSize: 14),
      prefixIcon: Icon(icon, color: const Color(0xFF8B8F9B), size: 21),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF8F9FC),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFE9EAF0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFE45757)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFE45757), width: 1.5),
      ),
    );
  }
}
