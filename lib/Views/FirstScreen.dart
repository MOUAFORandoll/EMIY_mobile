import 'package:EMIY/Views/Home/SearchView.dart';
import 'package:EMIY/controller/ActionController.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/controller/productController.dart';
import 'package:EMIY/styles/textStyle.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'CategoryBoutique/CategoryView.dart';

class FirstScreen extends StatelessWidget {
  /* StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> { */
  // int _currentIndex = 0;
  // bool _isVisible = true;
  // late ScrollController controller;

  // @override
  // void initState() {
  // iniit();
  // super.initState();
  // controller = ScrollController();
  // Get.find<ActionController>().scrollcontroller.addListener(() {
  //   //print(Get.find<ActionController>().scrollcontroller.position);

  //   setState(() {
  //     //print(_isVisible);
  //     _isVisible = Get.find<ActionController>()
  //             .scrollcontroller
  //             .position
  //             .userScrollDirection ==
  //         ScrollDirection.forward;
  //   });
  // });
  // }

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
  //     await Get.find<ActionController>().getLanguageInit();

  //     Get.find<ManagerController>().getKeyU();
  //     Get.find<ManagerController>().getUser();

  //     Get.find<ManagerController>().newLocalisation();

  //     Get.find<CommandeController>().getListCommandes();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActionController>(
        builder: (_controller) => Scaffold(
              // extendBody for floating bar get better perfomance
              // extendBody: true,
              backgroundColor: Colors.white,

              body: SafeArea(child: _controller.buildContent()),

              bottomNavigationBar: _controller.buildBorderRadiusDesign(),
            ));
  }
/* 
  Widget _buildContent(index) {
    switch (index) {
      case 0:
        return HomeView();
      // case 1:
      //   return SearchView();
      case 1:
        //   return ListBoutiqueView();
        // case 2:
        return CategoryView();

      // case 2:
      //   return SearchView();
      case 2:
        return ShoppingView();

      case 3:
        return ManageView();

      // case 4:
      //   return ProfileUserView();

      default:
        return HomeView();
    }
  }

  Widget _buildBorderRadiusDesign() {
    return GetBuilder<CartController>(builder: (_controller) {
      return CustomNavigationBar(
        iconSize: 30.0,
        // elevation: 0.0,
        scaleFactor: 0.4,
        selectedColor: Color(0xff0c18fb),
        strokeColor: Color(0x300c18fb),
        unSelectedColor: Colors.grey[600],
        backgroundColor: ColorsApp.greySearch,
        // borderRadius: Radius.circular(15.0),
        // isFloating: true,
        // blurEffect: true,
        items: [
          CustomNavigationBarItem(
              icon: Container(
                height: kSmHeight / 1.7,
                width: kSmWidth / 4.2,
                child: SvgPicture.asset(
                  Assets.home,
                  width: 90,
                  height: 90,
                  color:
                      _currentIndex == 0 ? ColorsApp.skyBlue : ColorsApp.grey,
                ),
              ),
              title: Container(
                  padding: EdgeInsets.only(bottom: 3),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: _currentIndex == 0
                              ? BorderSide(color: ColorsApp.skyBlue, width: 2)
                              : BorderSide.none,
                          top: BorderSide.none)),
                  child: Text('home'.tr,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: _currentIndex == 0
                            ? ColorsApp.skyBlue
                            : ColorsApp.grey,
                      )))), // CustomNavigationBarItem(

          CustomNavigationBarItem(
            icon: Container(
              height: kSmHeight / 1.7,
              width: kSmWidth / 4.2,
              child: SvgPicture.asset(
                Assets.grid1,
                width: 80,
                height: 80,
                color: _currentIndex == 1 ? ColorsApp.skyBlue : ColorsApp.grey,
              ),
            ),
            title: Container(
                padding: EdgeInsets.only(bottom: 3),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: _currentIndex == 1
                            ? BorderSide(color: ColorsApp.skyBlue, width: 2)
                            : BorderSide.none,
                        top: BorderSide.none)),
                child: Text('categories'.tr,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: _currentIndex == 1
                          ? ColorsApp.skyBlue
                          : ColorsApp.grey,
                    ))),
          ),

          CustomNavigationBarItem(
            icon: Container(
              height: kSmHeight / 1.7,
              width: kSmWidth / 4.2,
              child: SvgPicture.asset(
                Assets.shoppingCart,
                width: 90,
                height: 90,
                color: _currentIndex == 2 ? ColorsApp.skyBlue : ColorsApp.grey,
              ),
            ),
            title: Container(
                padding: EdgeInsets.only(bottom: 3),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: _currentIndex == 2
                            ? BorderSide(color: ColorsApp.skyBlue, width: 2)
                            : BorderSide.none,
                        top: BorderSide.none)),
                child: Text('Shop',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: _currentIndex == 2
                          ? ColorsApp.skyBlue
                          : ColorsApp.grey,
                    ))),
          ),

          CustomNavigationBarItem(
            icon: Container(
              height: kSmHeight / 1.7,
              width: kSmWidth / 4.2,
              child: Icon(
                Icons.settings,
                size: 25,
                color: _currentIndex == 3 ? ColorsApp.skyBlue : ColorsApp.grey,
              ),
            ),
            title: Container(
                padding: EdgeInsets.only(bottom: 3),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: _currentIndex == 3
                            ? BorderSide(color: ColorsApp.skyBlue, width: 2)
                            : BorderSide.none,
                        top: BorderSide.none)),
                child: Text('setting'.tr,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: _currentIndex == 3
                          ? ColorsApp.skyBlue
                          : ColorsApp.grey,
                    ))),

            // badgeCount: _badgeCounts[4],
            // showBadge: _badgeShows[4],
          ),
          // CustomNavigationBarItem(
          //   icon: Icon(Icons.hourglass_disabled),
          //   badgeCount: _badgeCounts[4],
          //   showBadge: _badgeShows[4],
          // ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.find<ProductController>().restoreScrollPosition();
            });
          }
        },
      );
    });
  }
 */
}

/**
 * import 'package:EMIY/components/Button/btnCatList.dart';
import 'package:EMIY/components/Button/btnCatListPV.dart';
import 'package:EMIY/components/Button/button.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Widget/productComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/controller/popularproductController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(controller: _scrollController, slivers: [
     
      SliverAppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Provide a standard title.
        // title: Text('title'),
        // Allows the user to reveal the app bar if they begin scrolling
        // back up the list of items.
        floating: true,
        // Display a placeholder widget to visualize the shrinking size.
        flexibleSpace: Container(
          margin: EdgeInsets.only(top: Get.height * .030, left: 0),
          padding:
              EdgeInsets.only(left: Get.width * .030, right: Get.width * .030),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            BigtitleText(text: 'Home', bolder: true),
            Container(
                child: InkWell(
                    child: Icon(Icons.search),
                    onTap: () => Scaffold.of(context).openDrawer())
                // padding: EdgeInsets.only(right: 10),
                ),
          ]),

          /*   onTap: () => filterDest() */
        ),
        // Make the initial height of the SliverAppBar larger than normal.
        expandedHeight: 60,
      ),

      SliverList(
       
        delegate: SliverChildBuilderDelegate(
          // The builder function returns a ListTile with a title that
          // displays the index of the current item.
          (context, index) => Container(
              margin: EdgeInsets.symmetric(horizontal: kMarginX),
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    titleText(text: 'Categorie'),
                    GetBuilder<CategoryController>(builder: (categorys) {
                      return categorys.isLoaded == 0
                          ? Center(
                              child: CircularProgressIndicator(
                                color: ColorsApp.bleuLight,
                              ),
                            )
                          : categorys.isLoaded == 1
                              ? Container(
                                  height: kSmHeight,
                                  margin: EdgeInsets.symmetric(
                                      vertical: kMarginY * .2),
                                  child: ListView.builder(
                                    itemCount: categorys.categoryList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (_ctx, index) =>
                                        CategoryComponent(
                                      category: categorys.categoryList[index],
                                    ),
                                  ),
                                )
                              : Center(
                                  child: smallText(
                                  text: 'error',
                                ));
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleText(text: 'Populaire(s)'),
                        Container(
                            margin: EdgeInsets.only(
                                top: Get.height * .005, left: Get.width * .008),
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              // color: Colors.white,
                            )),
                      ],
                    ),
                    GetBuilder<ProductController>(builder: (prods) {
                      return prods.isLoadedP == 0
                          ? Center(
                              child: CircularProgressIndicator(
                                color: ColorsApp.bleuLight,
                              ),
                            )
                          : prods.isLoadedP == 1
                              ? Container(
                                  height: kMdHeight * .25,
                                  margin: EdgeInsets.symmetric(
                                      vertical: kMarginY * .2),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: prods.produitList.length,
                                    itemBuilder: (_ctx, index) =>
                                        ProductComponent(
                                            produit: prods.produitList[index],
                                            index: index),
                                  ),
                                )
                              : Center(
                                  child: smallText(
                                  text: 'error',
                                ));
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleText(text: 'All'),
                        Container(
                            margin: EdgeInsets.only(
                                top: Get.height * .005, left: Get.width * .008),
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              // color: Colors.white,
                            )),
                      ],
                    ),
                    SingleChildScrollView(
                        child: GridView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 30.0,
                                    mainAxisSpacing: 1.0),
                            itemCount: 200,
                            itemBuilder: (_ctx, index) =>
                                Text(index.toString())))
                  ]))),

          // Builds 1000 ListTiles
          childCount: 1,
        ),
      )
    ]);
  }
}

 */
