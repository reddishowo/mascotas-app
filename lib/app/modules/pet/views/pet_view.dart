import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../controllers/pet_controller.dart';
import '../../../data/models/pet_model.dart';
import '../../navbar/views/navbar_view.dart';

class PetView extends GetView<PetController> {
  const PetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PetListPage();
  }
}

class PetCard extends StatelessWidget {
  final Pet pet;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PetCard({
    Key? key,
    required this.pet,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Obx(() => Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: pet.imageUrl.value.isNotEmpty
                      ? FileImage(File(pet.imageUrl.value))
                      : AssetImage('assets/images/default_pet_image.png') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                  pet.name.value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                SizedBox(height: 4),
                Obx(() => Text(
                  '${pet.type.value} - ${pet.breed.value} - Age: ${pet.age.value}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                )),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PetListPage extends GetView<PetController> {
  PetListPage({Key? key}) : super(key: key);

  final ImagePicker _picker = ImagePicker();

  Future<void> _showPetForm(BuildContext context, {Pet? pet}) async {
    final isUpdating = pet != null;
    final formPet = pet ?? Pet(name: '', type: '', breed: '', age: 0, imageUrl: '');

    String? imageFilePath;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isUpdating ? 'Update Pet' : 'Add Pet'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      imageFilePath = pickedFile.path;
                      formPet.imageUrl.value = imageFilePath!;
                    }
                  },
                  child: Obx(() => CircleAvatar(
                    radius: 50,
                    backgroundImage: formPet.imageUrl.value.isNotEmpty
                        ? FileImage(File(formPet.imageUrl.value))
                        : null,
                    child: formPet.imageUrl.value.isEmpty
                        ? Icon(Icons.add_a_photo, size: 40)
                        : null,
                  )),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: (value) => formPet.name.value = value,
                  controller: TextEditingController(text: formPet.name.value),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Type (Dog, Cat, etc.)'),
                  onChanged: (value) => formPet.type.value = value,
                  controller: TextEditingController(text: formPet.type.value),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Breed'),
                  onChanged: (value) => formPet.breed.value = value,
                  controller: TextEditingController(text: formPet.breed.value),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => formPet.age.value = int.tryParse(value) ?? 0,
                  controller: TextEditingController(text: formPet.age.value.toString()),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text(isUpdating ? 'Update' : 'Add'),
              onPressed: () {
                if (isUpdating) {
                  controller.updatePet(pet.id.value, formPet);
                } else {
                  controller.addPet(formPet);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            color: Colors.white,
            child: Row(
              children: [
                const Text(
                  'Pets',
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
          Expanded(
            child: Obx(() => controller.pets.isEmpty
                ? Center(
                    child: Text('No pets added yet!',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
                : ListView.builder(
                    itemCount: controller.pets.length,
                    itemBuilder: (context, index) {
                      final pet = controller.pets[index];
                      return PetCard(
                        pet: pet,
                        onEdit: () => _showPetForm(context, pet: pet),
                        onDelete: () => controller.deletePet(pet.id.value),
                      );
                    },
                  ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showPetForm(context),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}