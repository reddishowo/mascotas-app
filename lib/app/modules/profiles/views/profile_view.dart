import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../navbar/views/navbar_view.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          _buildStats(),
          _buildMenuItems(),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.orange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Icon(Icons.settings, color: Colors.white),
              ],
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 60, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Obx(() => Text(
              controller.name.value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )),
            Obx(() => Text(
              controller.location.value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('Pets', controller.petCount),
          _buildStatItem('Breeds', controller.breedCount),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, RxInt count) {
    return Column(
      children: [
        Obx(() => Text(
          count.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        )),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItems() {
    return Expanded(
      child: ListView(
        children: [
          _buildMenuItem('Your Profile', Icons.person),
          _buildMenuItem('Manage Address', Icons.location_on),
          _buildMenuItem('My Schedule', Icons.calendar_today),
          _buildMenuItem('My Wallet', Icons.account_balance_wallet),
          _buildMenuItem('History Payment', Icons.history),
          _buildMenuItem('Help Center', Icons.help),
          _buildMenuItem('Privacy Policy', Icons.privacy_tip),
          _buildMenuItem('Sign Out', Icons.door_back_door),          
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        // Handle menu item tap
      },
    );
  }
}