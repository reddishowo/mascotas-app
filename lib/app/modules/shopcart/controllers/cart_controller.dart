import 'package:get/get.dart';
import '../../shop/controllers/shop_controller.dart';

class CartController extends GetxController {
  final ShopController shopController = Get.find<ShopController>();
  var cartItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    updateCartFromShop();
  }

  // This method populates cartItems based on shopController's cartItems
  void updateCartFromShop() {
    cartItems.clear();
    for (var item in shopController.cartItems) {
      var existingItem = cartItems.firstWhereOrNull(
        (element) => element['name'] == item,
      );
      if (existingItem != null) {
        existingItem['quantity']++;
      } else {
        cartItems.add({
          'name': item,
          'price': getPrice(item),
          'quantity': 1,
          'imageUrl': 'assets/images/${item.toLowerCase().replaceAll(' ', '_')}.png',
        });
      }
    }
    updateTotals();  // Update totals when cart is updated
  }

  // Method to get the price of an item
  int getPrice(String item) {
    switch (item) {
      case 'MeowMix Indoor health':
        return 60000;
      case '9Lives GentleCare':
        return 50000;
      case 'Royal Canin Kitten':
      case 'Royal Canin Persian':
        return 100000;
      default:
        return 0;
    }
  }

  // Method to remove an item from the cart
  void removeFromCart(String productName) {
    shopController.cartItems.remove(productName);
    updateCartFromShop();
  }

  // Method to increase the quantity of a specific item
  void increaseQuantity(String productName) {
    var item = cartItems.firstWhere((element) => element['name'] == productName);
    item['quantity']++;
    updateTotals();  // Update totals when quantity changes
  }

  // Method to decrease the quantity of a specific item
  void decreaseQuantity(String productName) {
    var item = cartItems.firstWhere((element) => element['name'] == productName);
    if (item['quantity'] > 1) {
      item['quantity']--;
    } else {
      removeFromCart(productName);  // Remove item if quantity becomes zero
    }
    updateTotals();  // Update totals when quantity changes
  }

  // Method to calculate subtotal
  String get subtotal {
    int total = cartItems.fold(0, (sum, item) => sum + (item['price'] as int) * (item['quantity'] as int));
    return formatCurrency(total);
  }

  // Method to calculate tax (10% of subtotal)
  String get tax {
    int taxAmount = (int.parse(subtotal.replaceAll(RegExp(r'[^\d]'), '')) * 0.1).round();
    return formatCurrency(taxAmount);
  }

  // Method to calculate the total (subtotal + tax)
  String get total {
    int totalAmount = int.parse(subtotal.replaceAll(RegExp(r'[^\d]'), '')) + 
                      int.parse(tax.replaceAll(RegExp(r'[^\d]'), ''));
    return formatCurrency(totalAmount);
  }

  // Helper method to format the currency
  String formatCurrency(int amount) {
    return '${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  // Method to update the totals after any quantity or item update
  void updateTotals() {
    subtotal;  // Trigger recalculation of subtotal
    tax;       // Trigger recalculation of tax
    total;     // Trigger recalculation of total
  }
}
