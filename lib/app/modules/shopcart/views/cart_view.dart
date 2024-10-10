import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8), // Light grey background
      appBar: AppBar(
        title: Text('Cart', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() => controller.cartItems.isEmpty
          ? Center(child: Text('Your cart is empty!'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16.0),
                            leading: Hero(
                              tag: 'cartItem_${item['name']}_$index', // Updated unique tag
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(item['imageUrl'], width: 50, height: 50, fit: BoxFit.cover),
                              ),
                            ),
                            title: Text(
                              item['name'],
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: Text(
                              'for 2-3 years',
                              style: TextStyle(color: Colors.grey),
                            ),
                            trailing: Container(
                              width: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Rp.${controller.formatCurrency(item['price'] * item['quantity'])}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red, size: 20),
                                    onPressed: () => controller.removeFromCart(item['name']),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                bottomCheckoutSection(),
              ],
            )),
    );
  }

  Widget bottomCheckoutSection() {
    return Obx(() => Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, -1),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${controller.cartItems.length} Items', style: TextStyle(fontSize: 16)),
                  Text(
                    'Rp.${controller.subtotal}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tax', style: TextStyle(fontSize: 16)),
                  Text(
                    'Rp.${controller.tax}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Totals', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(
                    'Rp.${controller.total}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Implement checkout logic here
                },
                child: Text(
                  'Checkout',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
