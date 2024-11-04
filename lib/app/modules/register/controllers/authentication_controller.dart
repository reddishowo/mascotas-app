import 'package:cloud_firestore/cloud_firestore.dart'; // Tambahkan ini untuk Firestore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/views/home_view.dart';
import '../../login/views/login_view.dart';

class AuthenticationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance
  RxBool isLoading = false.obs;

  // Fungsi untuk registrasi pengguna
  Future<void> registerUser(String name, int age, String email, String password) async {
    try {
      isLoading.value = true;
      // Membuat akun baru
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Simpan data pengguna ke Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': name,
        'age': age,
        'email': email,
      });

      Get.snackbar('Success', 'Registration successful',
          backgroundColor: Colors.green);
      Get.off(HomeView());
    } catch (error) {
      Get.snackbar('Error', 'Registration failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk login pengguna
  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('Success', 'Login successful',
          backgroundColor: Colors.green);
    } catch (error) {
      Get.snackbar('Error', 'Login failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    await _auth.signOut();
    Get.offAll(LoginView());
  }
}
