import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';

class RegisterView extends StatefulWidget {
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final AuthenticationController _authController =
      Get.put(AuthenticationController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Mascotas title
                const Text(
                  'Mascotas',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cursive',
                  ),
                ),
                const SizedBox(height: 8),

                // Tagline text
                const Text(
                  'Ciptakan hidup sehat untuk sahabat berbulu kesayanganmu',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),

                // Image of dog and cat
                Image.asset(
                  'assets/images/pet_logo.png',
                  height: 300,
                  width: 300,
                ),
                const SizedBox(height: 32),

                // Email TextField
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Password TextField with show/hide functionality
                StatefulBuilder(
                  builder: (context, setState) {
                    return TextField(
                      controller: _passwordController,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Register Button with Obx
                Obx(() => SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _authController.isLoading.value
                            ? null
                            : () {
                                if (_emailController.text.trim().isEmpty ||
                                    _passwordController.text.trim().isEmpty) {
                                  Get.snackbar('Error', 'Please fill in both fields');
                                  return;
                                }
                                _authController.registerUser(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 30,
                          ),
                        ),
                        child: _authController.isLoading.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'Register',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    )),
                const SizedBox(height: 16),

                // "Or" divider with text
                const Row(
                  children: [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('atau'),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                const SizedBox(height: 16),

                // Social Media Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/icons/google.png'),
                      iconSize: 40,
                      onPressed: () {
                        // Google sign-in logic
                      },
                    ),
                    IconButton(
                      icon: Image.asset('assets/icons/facebook.png'),
                      iconSize: 40,
                      onPressed: () {
                        // Facebook sign-in logic
                      },
                    ),
                    IconButton(
                      icon: Image.asset('assets/icons/apple.png'),
                      iconSize: 40,
                      onPressed: () {
                        // Apple sign-in logic
                      },
                    ),
                  ],
                ),
                
                // Link to Login
                TextButton(
                  onPressed: () => Get.toNamed('/login'),
                  child: const Text(
                    'Sudah punya akun? Login di sini',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}