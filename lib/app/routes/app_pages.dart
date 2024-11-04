import 'package:get/get.dart';
import 'package:mobile_app_backup/app/modules/pet/bindings/pet_binding.dart';
import 'package:mobile_app_backup/app/modules/pet/views/pet_view.dart';
import 'package:mobile_app_backup/app/modules/register/views/register_view.dart';
import 'package:mobile_app_backup/app/modules/shop/views/shop_views.dart';
import 'package:mobile_app_backup/app/modules/shopcart/bindings/cart_binding.dart';

import '../modules/article_details/bindings/articledetail_binding.dart';
import '../modules/article_details/views/articledetail_view.dart';
import '../modules/article_details/views/articledetail_webview.dart';
import '../modules/getconnect/bindings/getconnect_binding.dart';
import '../modules/getconnect/views/getconnect_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';
import '../modules/petdetails/bindings/petdetail_binding.dart';
import '../modules/petdetails/views/petdetail_view.dart';
import '../modules/profiles/binding/profile_binding.dart';
import '../modules/profiles/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/shop/bindings/shop_binding.dart';
import '../modules/shopcart/views/cart_view.dart';
import '../modules/splashscreen/bindings/splash_binding.dart';
import '../modules/splashscreen/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
  static const LOGIN = Routes.LOGIN;
  static const REGISTER = Routes.REGISTER;
  static const PROFILE = Routes.PROFILE;
  static const SHOP = Routes.SHOP;
  static const CART = Routes.CART;
  static const PET = Routes.PET;
  static const PETDETAIL = Routes.PETDETAIL;
  

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      bindings: [
      SplashBinding(),
      RegisterBinding(),
    ]),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      bindings: [
      SplashBinding(),
      RegisterBinding(),
      LoginBinding(),
      NavbarBinding()
    ]),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      bindings: [
      SplashBinding(),
      RegisterBinding(),
      LoginBinding()
    ]),
    GetPage(
      name: _Paths.HOME, 
      page: () => HomeView(), 
      bindings: [
      HomeBinding(),
      NavbarBinding(),
      PetBinding(),
    ]),
    GetPage(
      name: _Paths.SHOP,
      page: () => ShopView(),
      bindings: [
      ShopBinding(),
      NavbarBinding(),
    ],
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      bindings: [
      ShopBinding(),
      NavbarBinding(),
      CartBinding(),
    ],
    ),
    GetPage(
      name: _Paths.PET,
      page: () => PetView(),
      bindings: [
      PetBinding(),
      NavbarBinding(),
      PetDetailBinding(),
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
    ),
    GetPage(
      name: Routes.PETDETAIL,
      page: () => const PetDetailView(),
      bindings: [
        PetDetailBinding(),
        NavbarBinding(),
    ],
    ),
    GetPage(
      name: _Paths.GETCONNECT,
      page: () => const GetConnectView(),
      bindings: [
        GetConnectBinding(),
        NavbarBinding(),
    ],
    ),
    GetPage(
        name: _Paths.ARTICLE_DETAILS,
        page: () => ArticleDetailPage(article: Get.arguments),
      bindings: [
        ArticleDetailBinding(),
        NavbarBinding(),
    ],
    ),
    GetPage(
        name: _Paths.ARTICLE_DETAILS_WEBVIEW,
        page: () => ArticleDetailWebView(article: Get.arguments),
      bindings: [
        ArticleDetailBinding(),
        NavbarBinding(),
    ],
    )
  ];
}
