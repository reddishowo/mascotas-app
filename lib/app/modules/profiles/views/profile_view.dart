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
          colors: [Colors.blue, Colors.purple, Colors.orange],
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
              backgroundImage: AssetImage('assets/default_avatar.png'),
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
    return Container(
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
    return Container(
      width: 100,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
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
      ),
    );
  }

  Widget _buildMenuItems() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildMenuItem('Your Profile',icon: Icons.person,),
          _buildMenuItem('Manage Address', icon: Icons.location_on,),
          _buildMenuItem('My Schedule', icon: Icons.calendar_today),
          _buildMenuItem('My Wallet', icon: Icons.account_balance_wallet_outlined),
          _buildMenuItem('History Payment', icon: Icons.history),
          _buildMenuItem('Help Center', icon: Icons.help_outline),
          _buildMenuItem('Privacy Policy', icon: Icons.lock_outline),
          _buildMenuItem('Sign Out', icon: Icons.door_back_door), 
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, {IconData? icon}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: icon != null ? Icon(icon, color: Colors.grey) : null,
        title: Text(title),
        trailing: Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          // Handle menu item tap
        },
      ),
    );
  }
}