import 'package:get/get.dart';
import '../../../data/models/pet_model.dart';

class PetDetailController extends GetxController {
  final Rx<Pet> pet = Pet(name: '', type: '', breed: '', age: 0).obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Pet) {
      pet.value = Get.arguments;
    }
  }

  void toggleFavorite() {
    // Implement favorite functionality here
    // For example, you could have a boolean isFavorite in your Pet model
    // pet.update((val) {
    //   val?.isFavorite = !(val.isFavorite ?? false);
    // });
  }

  void navigateToAboutPet() {
    // Implement navigation to About Pet page
    // Get.to(() => AboutPetView(pet: pet.value));
  }

  void navigateToPetHealth() {
    // Implement navigation to Pet Health page
    // Get.to(() => PetHealthView(pet: pet.value));
  }

  void navigateToDailyCare() {
    // Implement navigation to Daily Care page
    // Get.to(() => DailyCareView(pet: pet.value));
  }
}