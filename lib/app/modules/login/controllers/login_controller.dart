import 'package:get/get.dart';

class LoginController extends GetxController {
  // Predefined credentials for login
  final String correctUsername = 'admin';
  final String correctPassword = '12345';

  // Function to validate username and password
  bool validateLogin(String username, String password) {
    if (username == correctUsername && password == correctPassword) {
      return true;
    } else {
      return false;
    }
  }
}
