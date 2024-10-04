import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    bool _obscurePassword = true;

    return Scaffold(
      // Menggunakan resizeToAvoidBottomInset agar tampilan menyesuaikan dengan keyboard
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          // Membungkus konten dengan SingleChildScrollView agar dapat di-scroll
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
                  'assets/images/pet_logo.png', // replace with the image path in your assets
                  height: 200, // Mengurangi ukuran gambar untuk mencegah overflow
                  width: 200,
                ),
                const SizedBox(height: 32),

                // Email TextField
                TextField(
                  controller: emailController,
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
                      controller: passwordController,
                      obscureText: _obscurePassword,
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
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Login Button
                ElevatedButton(
                  onPressed: () {
                    String email = emailController.text;
                    String password = passwordController.text;

                    // Validate credentials
                    if (controller.validateLogin(email, password)) {
                      Get.toNamed('/home'); // Navigate to HomeView
                    } else {
                      Get.snackbar('Error', 'Invalid email or password');
                    }
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
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),

                // "Or" divider with text
                Row(
                  children: const [
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
                      icon: Image.asset('assets/icons/google.png'), // Replace with actual Google icon
                      iconSize: 40,
                      onPressed: () {
                        // Google sign-in logic
                      },
                    ),
                    IconButton(
                      icon: Image.asset('assets/icons/facebook.png'), // Replace with actual Facebook icon
                      iconSize: 40,
                      onPressed: () {
                        // Facebook sign-in logic
                      },
                    ),
                    IconButton(
                      icon: Image.asset('assets/icons/apple.png'), // Replace with actual Apple icon
                      iconSize: 40,
                      onPressed: () {
                        // Apple sign-in logic
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
