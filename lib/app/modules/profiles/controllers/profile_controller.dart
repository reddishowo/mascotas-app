// File: /lib/app/modules/profiles/controllers/profile_controller.dart

import 'package:get/get.dart';
import '../../pet/controllers/pet_controller.dart';

class ProfileController extends GetxController {
  final PetController _petController = Get.find<PetController>();

  final RxString name = 'Admin'.obs;
  final RxString location = 'Malang'.obs;
  final RxInt petCount = 0.obs;
  final RxInt breedCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    updatePetAndBreedCount();
    ever(_petController.pets, (_) => updatePetAndBreedCount());
  }

  void updatePetAndBreedCount() {
    petCount.value = _petController.pets.length;
    breedCount.value = _petController.pets.map((pet) => pet.breed.value).toSet().length;
  }
}