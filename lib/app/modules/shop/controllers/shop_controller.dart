import 'package:get/get.dart';

class ShopController extends GetxController {
  // Observable list to store the selected category
  var selectedCategory = 'Food'.obs;

  // Cart items (this can be a list of products, simplified as string here)
  var cartItems = <String>[].obs;

  // List of available products (dummy data for now)
  final products = [
    {'name': 'MeowMix Indoor health', 'price': 'Rp.60.000'},
    {'name': '9Lives GentleCare', 'price': 'Rp.50.000'},
    {'name': 'Royal Canin Kitten', 'price': 'Rp.100.000'},
    {'name': 'Royal Canin Persian', 'price': 'Rp.100.000'},
  ];

  // Function to change the selected category
  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  // Function to add a product to the cart
  void addToCart(String productName) {
    cartItems.add(productName);
    Get.snackbar('Added to Cart', '$productName has been added to your cart',
        snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 2));
  }

  // Function to get the number of items in the cart
  int get cartCount => cartItems.length;
}
