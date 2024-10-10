import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../navbar/views/navbar_view.dart';
import '../controllers/petdetail_controller.dart';
import 'dart:io';

class PetDetailView extends GetView<PetDetailController> {
  const PetDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Obx(() => Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: controller.pet.value.imageUrl.value.isNotEmpty
                              ? FileImage(File(controller.pet.value.imageUrl.value))
                              : AssetImage('assets/images/default_pet_image.png') as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Get.back(),
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: Offset(0, -40),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => Text(
                              controller.pet.value.name.value,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            )),
                        Icon(Icons.male, color: Colors.blue),
                      ],
                    ),
                    SizedBox(height: 8),
                    Obx(() => Text(
                          '${controller.pet.value.type.value}, ${controller.pet.value.weight.value} kg',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: controller.toggleFavorite,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.grey[200],
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Add To Fav Pet !', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildIconButton(Icons.pets, 'About\nPet', Colors.blue, controller.navigateToAboutPet),
                  _buildIconButton(Icons.favorite, 'Pet Health', Colors.blue, controller.navigateToPetHealth),
                  _buildIconButton(Icons.calendar_today, 'Daily\nCare', Colors.blue, controller.navigateToDailyCare),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildIconButton(IconData icon, String label, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
        ],
      ),
    );
  }
}