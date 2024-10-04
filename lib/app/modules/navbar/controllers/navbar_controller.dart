import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class NavbarController extends GetxController {
  // Track the selected index for the BottomNavigationBar
  var selectedIndex = 2.obs;

  // List of available routes based on the index
  final List<String> routes = [
    Routes.BOOKMARK, // 0
    Routes.LOCATION, // 1
    Routes.HOME, // 2
    Routes.PET, // 3
    Routes.PROFILE, // 4
  ];

  // Function to handle navigation based on index
  void onItemTapped(int index) {
    selectedIndex.value = index;
    Get.toNamed(routes[index]);
  }
}
