import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app_backup/app/modules/register/controllers/authentication_controller.dart'; // Firebase package for authentication

class LoginView extends GetView<AuthenticationController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    bool obscurePassword = true;

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
                  height: 300, // Mengurangi ukuran gambar untuk mencegah overflow
                  width: 300,
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

                // Login Button
                ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      Get.snackbar('Error', 'Please fill in both fields');
                      return;
                    }

                    // Show loading
                    controller.isLoading.value = true;

                    try {
                      // Firebase login logic
                      // ignore: unused_local_variable
                      UserCredential userCredential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      
                      // Navigate to home on successful login
                      Get.offNamed('/home');
                    } on FirebaseAuthException catch (e) {
                      String errorMsg = '';
                      if (e.code == 'user-not-found') {
                        errorMsg = 'No user found for that email.';
                      } else if (e.code == 'wrong-password') {
                        errorMsg = 'Wrong password provided.';
                      } else {
                        errorMsg = 'Something went wrong, try again later.';
                      }
                      Get.snackbar('Login Failed', errorMsg);
                    } finally {
                      controller.isLoading.value = false;
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
                  child: Obx(() {
                    return controller.isLoading.value
                        ? CircularProgressIndicator()
                        : const Text('Login', style: TextStyle(fontSize: 16));
                  }),
                ),
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
