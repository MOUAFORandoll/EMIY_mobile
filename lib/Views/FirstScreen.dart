import 'package:EMIY/Views/Search/SearchView.dart';
import 'package:EMIY/Views/UsersMange/RegisterScreen.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/linkController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/UniLinkService.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:EMIY/Views/ComplementView/AboutUsView.dart';
import 'package:EMIY/Views/Home/HomeView.dart';
import 'package:EMIY/Views/Shopping/ShoppingView.dart';
import 'package:EMIY/Views/UsersMange/ManageView.dart';
import 'package:EMIY/components/Widget/optionComponent.dart';
// import 'package:antdesign_icons/antdesign_icons.dart';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/utils/Services/dependancies.dart';
import 'package:flutter/material.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uni_links/uni_links.dart';

import 'CategoryBoutique/CategoryView.dart';
import 'UsersMange/LoginScreen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  // int _currentIndex = 0;
  // bool _isVisible = true;
  // late ScrollController controller;

  // @override
  void initState() {
    super.initState();
    Get.find<UniLinkService>().initURIHandler();
    Get.find<UniLinkService>().incomingLinkHandler();
    // Get.find<UniLinkService>().uniLink();
  }

  // iniit() async {
  //   // await MyBinding().requestPermission();
  //   var status = await Permission.storage.status;
  //   //print("voici le statut************* ,  $status");
  //   if (!status.isGranted) {
  //     await Permission.storage.request();
  //     await getData();
  //   } else {
  //     await getData();
  //   }
  // }

  // getData() async {
  //   // await MyBinding().requestPermission();
  //   var status = await Permission.storage.status;
  //   //print("voici le statut ,  $status");

  //   if (status.isGranted) {
  //     var database = dababase;
  //     await database.init();
  //     await Get.find<GeneralController>().getLanguageInit();

  //     Get.find<ManagerController>().getKeyU();
  //     Get.find<ManagerController>().getUser();

  //     Get.find<ManagerController>().newLocalisation();

  //     Get.find<CommandeController>().getListCommandes();
  //   }
  // }

  // uniLink() async {
  //   /**
  //    *
  //    le lien de parainage est sous cette forme :
  //    * https://emiy-shop.000webhostapp.com/{type}/trgg
  //    *
  //    * type :
  //    *    - produits => pour afficher un produit precis
  //    *    - subscribes => pour inscrire avec un parain
  //    *

  //    */
  //   try {
  //     final uri = await getInitialUri();
  //     if (uri == null) {
  //       print('no initial uri');
  //     } else {
  //       var direction = uri.path.split('/');
  //       var type = direction[1];
  //       print('--${uri}---00-lien----------ici----------------------');
  //       if (type == 'produits') {
  //         var codeProduit = direction[2];

  //         print('----------codeProduit--------${codeProduit}------');
  //         Get.find<LinkController>().getUniLinkProduit(codeProduit);
  //         Get.toNamed(AppLinks.PRODUCT_FOR_LINK);
  //       }
  //       if (type == 'boutiques') {
  //         var codeBoutique = direction[2];

  //         print('----------codeBoutique--------${codeBoutique}------');
  //         Get.find<LinkController>().getUniLinkBoutique(codeBoutique);
  //         Get.toNamed(AppLinks.BOUTIQUE_FOR_LINK);
  //       }

  //       if (type == 'subscribes') {
  //         var codeParrain = direction[2];
  //         print('----------codeParrain--------${codeParrain}------');
  //         Get.find<ManagerController>().setCodeParrain(codeParrain);
  //         Get.bottomSheet(
  //           Container(
  //               margin: EdgeInsets.only(
  //                 top: kMarginY * 8,
  //               ),
  //               decoration: BoxDecoration(
  //                   color: ColorsApp.white,
  //                   borderRadius: BorderRadius.only(
  //                       topLeft: Radius.circular(15),
  //                       topRight: Radius.circular(15))),
  //               height: 800,
  //               padding: EdgeInsets.symmetric(horizontal: kMarginX),
  //               child: Column(children: [
  //                 Container(
  //                   child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         TextButton(
  //                           child: Text('Annuler'),
  //                           onPressed: () {
  //                             Get.back();
  //                           },
  //                         ),
  //                         // TextButton(
  //                         //   child: Text('Ajouter'),
  //                         //   onPressed: () async {
  //                         //     // await _controller.addShort();
  //                         //     // _controller.chageState(!_controller.addProduit);
  //                         //   },
  //                         // )
  //                       ]),
  //                 ),
  //                 Expanded(
  //                     child: SingleChildScrollView(
  //                         child: Column(children: [
  //                   // _controller.listImgProduits.length != 0
  //                   //     ? smallText(
  //                   //         text: 'Listes images',
  //                   //       )
  //                   //     : Container(),

  //                   Container(
  //                       margin: EdgeInsets.only(
  //                         top: 50,
  //                       ),
  //                       child: RegisterScreen())
  //                 ])))
  //               ])),
  //           isScrollControlled: true,
  //         );
  //       }
  //       print('got initial uri: $uri');
  //     }
  //     // var direction = uri!.path!
  //   } on PlatformException {
  //     // Platform messages may fail but we ignore the exception
  //     print('falied to get initial uri');
  //   } on FormatException catch (err) {
  //     print('malformed initial uri');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // uniLink();
    return GetBuilder<GeneralController>(
        builder: (_controller) => Scaffold(
              backgroundColor: Colors.white,
              // drawer: CustomDrawer(),
              floatingActionButton: _controller.floatingActionButton(),
              body: SafeArea(child: _controller.buildContent()),
              bottomNavigationBar: _controller.buildBorderRadiusDesign(),
            ));
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: kWidth / 1.35,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('John Doe'),
            accountEmail: Text('john.doe@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Navigate to the home page or perform an action
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Navigate to the settings page or perform an action
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // Perform logout logic
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
