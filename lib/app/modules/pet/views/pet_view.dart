import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // For handling files (images)
import 'package:mobile_app_backup/app/modules/pet/controllers/pet_controller.dart';
import '../../navbar/views/navbar_view.dart';

// Pet model class
class Pet {
  String name;
  String type;
  String breed;
  int age;
  String imageUrl;

  Pet({
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    required this.imageUrl,
  });
}

// PetView with GetView<PetController>
class PetView extends GetView<PetController> {
  const PetView({super.key});

  @override
  Widget build(BuildContext context) {
    return PetListPage(); // Reference to the PetListPage UI
  }
}

/// Custom Pet Card Widget
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
      elevation: 8, // Increased elevation for a more pronounced shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(
          vertical: 10, horizontal: 16), // Adjusted margins
      child: Column(
        children: [
          // Displaying larger image
          ClipRRect(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(15)), // Rounded top corners
            child: Container(
              height: 200, // Increased height for the pet image
              width: double.infinity, // Full width
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: pet.imageUrl.isNotEmpty
                      ? FileImage(File(pet.imageUrl))
                      : AssetImage(
                          'assets/images/default_pet_image.png'), // Placeholder image
                  fit: BoxFit.cover, // Cover the entire container
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pet name
                Text(
                  pet.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Pet type, breed, and age
                SizedBox(height: 4),
                Text(
                  '${pet.type} - ${pet.breed} - Age: ${pet.age}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 16),
                // Edit and Delete buttons
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

// PetListPage State Management
class PetListPage extends StatefulWidget {
  @override
  _PetListPageState createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  List<Pet> pets = [];
  final ImagePicker _picker = ImagePicker();
  File? _imageFile; // To store the picked image

  void addPet(Pet pet) {
    setState(() {
      pets.add(pet);
    });
  }

  void updatePet(int index, Pet updatedPet) {
    setState(() {
      pets[index] = updatedPet;
    });
  }

  void deletePet(int index) {
    setState(() {
      pets.removeAt(index);
    });
  }

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void showPetForm({int? index}) {
    final isUpdating = index != null;
    final pet = isUpdating
        ? pets[index!]
        : Pet(name: '', type: '', breed: '', age: 0, imageUrl: '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String name = pet.name;
        String type = pet.type;
        String breed = pet.breed;
        int age = pet.age;
        String imageUrl = pet.imageUrl;

        return AlertDialog(
          title: Text(isUpdating ? 'Update Pet' : 'Add Pet'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage, // Trigger image picker
                  child: _imageFile == null && imageUrl.isEmpty
                      ? Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.add_a_photo),
                        )
                      : CircleAvatar(
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : NetworkImage(imageUrl) as ImageProvider,
                          radius: 50,
                        ),
                ),
                SizedBox(height: 20),
                _buildTextField('Name', (value) {
                  name = value;
                }, name),
                SizedBox(height: 10),
                _buildTextField('Type (Dog, Cat, etc.)', (value) {
                  type = value;
                }, type),
                SizedBox(height: 10),
                _buildTextField('Breed', (value) {
                  breed = value;
                }, breed),
                SizedBox(height: 10),
                _buildTextField('Age', (value) {
                  age = int.tryParse(value) ?? age;
                }, age.toString(), keyboardType: TextInputType.number),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final newPet = Pet(
                  name: name,
                  type: type,
                  breed: breed,
                  age: age,
                  imageUrl: _imageFile != null ? _imageFile!.path : imageUrl,
                );
                if (isUpdating) {
                  updatePet(index!, newPet);
                } else {
                  addPet(newPet);
                }
                Navigator.of(context).pop();
              },
              child: Text(isUpdating ? 'Update' : 'Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  TextField _buildTextField(
      String label, Function(String) onChanged, String initialValue,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
      controller: TextEditingController(text: initialValue),
      keyboardType: keyboardType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom Header from HomeView
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
                const SizedBox(width: 8), // Adjust this width for spacing
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
            child: pets.isEmpty
                ? Center(
                    child: Text('No pets added yet!',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)))
                : ListView.builder(
                    itemCount: pets.length,
                    itemBuilder: (context, index) {
                      final pet = pets[index];
                      return PetCard(
                        pet: pet,
                        onEdit: () => showPetForm(index: index),
                        onDelete: () => deletePet(index),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showPetForm(),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
