// File: /lib/app/modules/pet/controllers/pet_controller.dart

import 'package:get/get.dart';
import '../../../data/models/pet_model.dart';

class PetController extends GetxController {
  final RxList<Pet> pets = <Pet>[].obs;

  void addPet(Pet pet) {
    pets.add(pet);
    // Save to storage
  }

  void updatePet(String id, Pet updatedPet) {
    final index = pets.indexWhere((pet) => pet.id.value == id);
    if (index != -1) {
      pets[index] = updatedPet;
      // Save to storage
    }
  }

  void deletePet(String id) {
    pets.removeWhere((pet) => pet.id.value == id);
    // Save to storage
  }
}