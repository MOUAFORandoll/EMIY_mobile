import 'package:fahkapmobile/Views/Boutique/produitBoutiqueView.dart';
import 'package:fahkapmobile/Views/Category/ProductCategoryView.dart';
import 'package:fahkapmobile/Views/ComplementView/OnboardingScreen.dart';
import 'package:fahkapmobile/Views/FirstScreen.dart';
import 'package:fahkapmobile/Views/ComplementView/SplashScreen.dart';
import 'package:fahkapmobile/Views/Home/HomeView.dart';
import 'package:fahkapmobile/Views/Product/ProductView.dart';
import 'package:fahkapmobile/Views/Shopping/BuyShoopingCart.dart';
import 'package:fahkapmobile/Views/Shopping/ShoppingView.dart';
import 'package:fahkapmobile/Views/UsersMange/RegisterScreen.dart';
import 'package:fahkapmobile/Views/UsersMange/forgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:fahkapmobile/Views/UsersMange/LoginScreen.dart';
import 'package:fahkapmobile/Views/ComplementView/AboutUsView.dart';
// import 'package:fahkapmobile/Views/Home/AcheterBillet.dart';
import 'package:get/get.dart';

import '../../test.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: AppLinks.FIRST, page: () => FirstScreen()),
    GetPage(name: AppLinks.LOGIN, page: () => LoginScreen()),
    GetPage(name: AppLinks.HOME, children: [], page: () => HomeView()),
    GetPage(name: AppLinks.REGISTER, page: () => RegisterScreen()),
    GetPage(name: AppLinks.FORGOT, page: () => ForgotPassordScreen()),
    GetPage(name: AppLinks.CART, page: () => ShoppingView()),
    GetPage(name: AppLinks.BUYSHOP, page: () => BuyShoopingCart()),
    // GetPage(name: AppLinks.ABOUTUS, page: () => AboutUsScreen()),
    GetPage(name: AppLinks.SPLASHSCREEN, page: () => SplashScreenPage()),
    GetPage(name: AppLinks.TEST, page: () => Test()),
    GetPage(name: AppLinks.ONBOARDING, page: () => Onboarding()),
    GetPage(
        name: AppLinks.PRODUCT,
        // ignore: top_level_function_literal_block
        page: () {
          var index = Get.parameters['index'];
          return ProductView(index: int.parse(index!));
        }),
    GetPage(
        name: AppLinks.PRODUCT_FOR_CATEGORY, page: () => ProductCategoryView()),
    GetPage(
        name: AppLinks.PRODUCT_FOR_BOUTIQUE, page: () => ProduitBoutiqueView()),
  ];
}

class AppLinks {
  static const String PRODUCT_FOR_BOUTIQUE = "/pfb";
  static const String BUYSHOP = "/buyShop";
  static const String TEST = "/TEST";
  static const String LOGIN = "/login";
  static const String HOME = "/home";
  static const String REGISTER = "/register";
  static const String ABOUTUS = "/aboutus";
  static const String FORGOT = "/forgot";
  static const String FIRST = "/first";
  static const String CART = "/cart";
  static const String SPLASHSCREEN = "/splashscreen";
  static const String ONBOARDING = "/onboarding";
  static const String PRODUCT = "/product";
  static const String PRODUCT_FOR_CATEGORY = "/productfcategory";
}
