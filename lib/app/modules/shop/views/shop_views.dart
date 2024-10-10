import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../navbar/views/navbar_view.dart';
import '../controllers/shop_controller.dart';

class ShopView extends StatelessWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ShopController controller = Get.find<ShopController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('PetShop', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline, color: Colors.black),
            onPressed: () {},
          ),
          Obx(() => Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart_outlined, color: Colors.black),
              onPressed: () {
                Get.toNamed('/cart');
              },
              ),
              if (controller.cartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      '${controller.cartCount}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search meds here',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.green, size: 18),
                  SizedBox(width: 4),
                  Text(
                    'Delivery Address:',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Embong Arab, Malang',
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/meowmix.png',
                      height: 150,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Meow Mix Indoor Health',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Makanan Kucing Kering, menjaga berat badan tetap sehat',
                            style: TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(() => Row(
                  children: [
                    _buildCategoryButton('Food', controller.selectedCategory.value == 'Food', controller),
                    SizedBox(width: 8),
                    _buildCategoryButton('Drugs', controller.selectedCategory.value == 'Drugs', controller),
                    SizedBox(width: 8),
                    _buildCategoryButton('Accessories', controller.selectedCategory.value == 'Accessories', controller),
                  ],
                )),
              ),
              SizedBox(height: 16),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return _buildProductCard(product['name']!, product['price']!, 'assets/images/${product['name']!.toLowerCase().replaceAll(' ', '_')}.png', controller);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildCategoryButton(String title, bool isSelected, ShopController controller) {
    return GestureDetector(
      onTap: () => controller.changeCategory(title),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) Icon(Icons.sync, color: Colors.white, size: 16),
            if (isSelected) SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

    Widget _buildProductCard(String title, String price, String imagePath, ShopController controller) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200]!,
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: 'cartItem_$title', // Updated Hero tag to match CartView
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () => controller.addToCart(title),
                child: Icon(Icons.add, color: Colors.white),
                backgroundColor: Colors.blue,
                mini: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}