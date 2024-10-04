import 'package:get/get.dart';
import 'package:mobile_app_backup/app/modules/pet/bindings/pet_binding.dart';
import 'package:mobile_app_backup/app/modules/pet/views/pet_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';
import '../modules/profiles/binding/profile_binding.dart';
import '../modules/profiles/views/profile_view.dart';
import '../modules/splashscreen/bindings/splash_binding.dart';
import '../modules/splashscreen/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
  static const LOGIN = Routes.LOGIN;
  static const PROFILE = Routes.PROFILE;
  static const PET = Routes.PET;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(name: _Paths.HOME, page: () => HomeView(), bindings: [
      HomeBinding(),
      NavbarBinding(),
      PetBinding(),
    ]),
    GetPage(
      name: _Paths.PET,
      page: () => PetView(),
      bindings: [
      PetBinding(),
      NavbarBinding(),
    ] 
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      bindings: [
      ProfileBinding(),
      PetBinding(),
      NavbarBinding(),
    ]
    )
  ];
}
