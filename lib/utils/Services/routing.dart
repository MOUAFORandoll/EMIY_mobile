import 'package:fahkapmobile/Views/BoutiqueUser/CommadesBoutiqueUserView.dart';
import 'package:fahkapmobile/Views/UsersMange/CompteView.dart';
import 'package:fahkapmobile/Views/BoutiqueUser/HistroriqueCBUView.dart';
import 'package:fahkapmobile/Views/BoutiqueUser/manageBoutiqueUserView.dart';
import 'package:fahkapmobile/Views/BoutiqueUser/produitBoutiqueUserView.dart';
import 'package:fahkapmobile/Views/CategoryBoutique/BoutiqueCategoryView.dart';
import 'package:fahkapmobile/Views/CategoryBoutique/BoutiqueView.dart';
import 'package:fahkapmobile/Views/Commandes/CommandeView.dart';
import 'package:fahkapmobile/Views/Commandes/ProduitForCommande.dart';
import 'package:fahkapmobile/Views/ComplementView/OnboardingScreen.dart';
import 'package:fahkapmobile/Views/FirstScreen.dart';
import 'package:fahkapmobile/Views/ComplementView/SplashScreen.dart';
import 'package:fahkapmobile/Views/Home/HomeView.dart';
import 'package:fahkapmobile/Views/Home/ListBoutiquesView.dart';
import 'package:fahkapmobile/Views/Home/ListProduitsView.dart';
import 'package:fahkapmobile/Views/Product/ProductView.dart';
import 'package:fahkapmobile/Views/Shopping/BuyShoopingCart.dart';
import 'package:fahkapmobile/Views/Shopping/ShoppingView.dart';
import 'package:fahkapmobile/Views/Shopping/ShoppingViewNext.dart';
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
        name: AppLinks.PRODUCT_FOR_COMMANDE,
        // ignore: top_level_function_literal_block
        page: () {
          var id = Get.parameters['id'];
          var code = Get.parameters['code'];
          return ProduitForCommande(id: int.parse(id!), code: code!);
        }),
    GetPage(
        name: AppLinks.BOUTIQUE,
        // ignore: top_level_function_literal_block
        page: () {
          return BoutiqueView();
        }),
    GetPage(
        name: AppLinks.BOUTIQUE_FOR_CATEGORY,
        page: () => BoutiqueCategoryView()),
    GetPage(
        name: AppLinks.PRODUCT_FOR_BOUTIQUE,
        page: () => ProduitBoutiqueUserView()),
    GetPage(
        name: AppLinks.COMMANDE_FOR_BOUTIQUE,
        page: () => CommandesBoutiqueUserView()),

    GetPage(name: AppLinks.COMMANDE_FOR_USER, page: () => CommandeView()),
    GetPage(
        name: AppLinks.HISTORIQUE_FOR_BOUTIQUE,
        page: () => HistroriqueCBUView()),
    GetPage(
        name: AppLinks.MANAGE_FOR_BOUTIQUE,
        page: () => ManageBoutiqueUserView()),
    GetPage(name: AppLinks.SHOPNEXT, page: () => ShoppingViewNext()),

    GetPage(name: AppLinks.BOUTIQUE_READ_ALL, page: () => ListBoutiquesView()),
    GetPage(name: AppLinks.COMPTE_FOR_BOUTIQUE, page: () => CompteView()),
    GetPage(name: AppLinks.PRODUCT_READ_ALL, page: () => ListProduitsView()),
  ];
}

class AppLinks {
  static const String PRODUCT_FOR_COMMANDE = "/pfc";
  static const String BOUTIQUE = "/boutique";
  static const String MANAGE_FOR_BOUTIQUE = "/mfb";
  static const String COMPTE_FOR_BOUTIQUE = "/cb";
  static const String HISTORIQUE_FOR_BOUTIQUE = "/hfb";
  static const String COMMANDE_FOR_BOUTIQUE = "/cfb";
  static const String COMMANDE_FOR_USER = "/cfu";
  static const String PRODUCT_FOR_BOUTIQUE = "/pfb";
  static const String BUYSHOP = "/buyShop";
  static const String SHOPNEXT = "/shop";
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
  static const String BOUTIQUE_FOR_CATEGORY = "/bfc";
  static const String BOUTIQUE_READ_ALL = "/bra";
  static const String PRODUCT_READ_ALL = "/pra";
}
