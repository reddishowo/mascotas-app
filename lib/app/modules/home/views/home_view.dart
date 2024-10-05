import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../navbar/views/navbar_view.dart';
import '../controllers/home_controller.dart';
import '../../pet/controllers/pet_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final PetController petController = Get.find<PetController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Header with Mascotas Title
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              color: Colors.white,
              child: Row(
                children: [
                  const Text(
                    'Mascotas',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/icons/cat_icon.png',
                    height: 24,
                    width: 24,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.grey),

            // "Your Pets" Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Pets',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed('/pet'),
                    child: const Icon(Icons.chevron_right, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Horizontal Scroll of Pets
            SizedBox(
              height: 180,
              child: Obx(() => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: petController.pets.length,
                itemBuilder: (context, index) {
                  final pet = petController.pets[index];
                  return _buildPetCard(pet.name.value, pet.imageUrl.value);
                },
              )),
            ),
            const SizedBox(height: 20),

            // "Daily Care" Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Daily Care',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Daily Care Cards
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildDailyCareCard(
                    'Khalid Kashmiri',
                    'Pemeriksaan gigi karena pola makan',
                    '12.05.24',
                    '04.00',
                    'Petshop Rauls',
                  ),
                  _buildDailyCareCard(
                    'Khalid Kashmiri',
                    'Pemeriksaan gigi karena pola makan',
                    '12.05.24',
                    '04.00',
                    'Petshop Rauls',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Weekly Grooming Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildWeeklyGroomingCard(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildPetCard(String name, String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 20),
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: _buildPetImage(imagePath),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetImage(String imagePath) {
    if (imagePath.isNotEmpty) {
      final file = File(imagePath);
      if (file.existsSync()) {
        return Image.file(
          file,
          height: 120,
          fit: BoxFit.cover,
        );
      }
    }
    // Fallback to default image if file doesn't exist or path is empty
    return Image.asset(
      'assets/images/default_pet_image.png',
      height: 120,
      fit: BoxFit.cover,
    );
  }

  Widget _buildDailyCareCard(
    String petName,
    String description,
    String date,
    String time,
    String location,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.grey[600], size: 16),
                const SizedBox(width: 4),
                Text(date, style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 12),
                Icon(Icons.access_time, color: Colors.grey[600], size: 16),
                const SizedBox(width: 4),
                Text(time, style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.favorite, color: Colors.blue, size: 24),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      petName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      location,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyGroomingCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.pets, color: Colors.blue, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Weekly grooming',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Make ur lovely pet looks pretty and handsome with our grooming',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey[600]),
        ],
      ),
    );
  }
}