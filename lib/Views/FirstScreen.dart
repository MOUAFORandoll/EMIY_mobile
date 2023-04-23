import 'package:Fahkap/Views/Home/SearchView.dart';
import 'package:Fahkap/controller/ActionController.dart';
import 'package:Fahkap/controller/CommandeController.dart';
import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/utils/database/DataBase.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:Fahkap/Views/ComplementView/AboutUsView.dart';
import 'package:Fahkap/Views/Home/HomeView.dart';
import 'package:Fahkap/Views/Shopping/ShoppingView.dart';
import 'package:Fahkap/Views/UsersMange/ManageView.dart';
import 'package:Fahkap/components/Widget/optionComponent.dart';
// import 'package:antdesign_icons/antdesign_icons.dart';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/controller/cartController.dart';
import 'package:Fahkap/controller/categoryController.dart';
import 'package:Fahkap/utils/Services/dependancies.dart';
import 'package:flutter/material.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'CategoryBoutique/CategoryView.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int _currentIndex = 0;
  bool _isVisible = true;
  // late ScrollController controller;

  @override
  void initState() {
    // iniit();
    super.initState();
    // controller = ScrollController();
    // Get.find<ActionController>().scrollcontroller.addListener(() {
    //   print(Get.find<ActionController>().scrollcontroller.position);

    //   setState(() {
    //     print(_isVisible);
    //     _isVisible = Get.find<ActionController>()
    //             .scrollcontroller
    //             .position
    //             .userScrollDirection ==
    //         ScrollDirection.forward;
    //   });
    // });
  }

  iniit() async {
    // await MyBinding().requestPermission();
    var status = await Permission.storage.status;
    print("voici le statut************* ,  $status");
    if (!status.isGranted) {
      await Permission.storage.request();
      await getData();
    } else {
      await getData();
    }
  }

  getData() async {
    // await MyBinding().requestPermission();
    var status = await Permission.storage.status;
    print("voici le statut ,  $status");

    if (status.isGranted) {
      var database = Get.find<DB>();
      await database.init();
      await Get.find<ActionController>().getLanguageInit();

      Get.find<ManagerController>().getKeyU();
      Get.find<ManagerController>().getUser();

      Get.find<ManagerController>().newLocalisation();

      Get.find<CommandeController>().getListCommandes();
    }
  }

  List<int> _badgeCounts = List<int>.generate(5, (index) => index);

  List<bool> _badgeShows = List<bool>.generate(5, (index) => true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody for floating bar get better perfomance
      // extendBody: true,
      backgroundColor: Colors.white,

      body: SafeArea(child: _buildContent(_currentIndex)),

      bottomNavigationBar:
          Offstage(offstage: !_isVisible, child: _buildBorderRadiusDesign()),
    );
  }

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
        backgroundColor: Colors.black,
        // borderRadius: Radius.circular(15.0),
        // isFloating: true,
        // blurEffect: true,
        items: [
          CustomNavigationBarItem(
              icon: Icon(Icons.home),
              // badgeCount: _badgeCounts[0],
              // showBadge: _badgeShows[0],
              title: Text('home', style: TextStyle(color: Colors.grey[600]))),
          // CustomNavigationBarItem(
          //   icon: Icon(Icons.search),
          //   badgeCount: _badgeCounts[3],
          //   showBadge: _badgeShows[3],
          // ),
          // CustomNavigationBarItem(
          //   icon: Icon(Icons.leave_bags_at_home),
          //   // badgeCount: _badgeCounts[2],
          //   // showBadge: _badgeShows[2],
          // ),
          CustomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.bars,
              size: 25,
            ),
            title: Text('Category', style: TextStyle(color: Colors.grey[600])),

            // badgeCount: _badgeCounts[2],
            // showBadge: _badgeShows[2],
          ),
          // CustomNavigationBarItem(
          //   icon: Icon(Icons.search),
          //   // badgeCount: _badgeCounts[2],
          //   title: Text('Search', style: TextStyle(color: Colors.grey[600])),
          //   // showBadge: _badgeShows[2],
          // ),
          CustomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.shoppingCart),
            title: Text('Shop', style: TextStyle(color: Colors.grey[600])),
          
          ),

          CustomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('setting', style: TextStyle(color: Colors.grey[600])),

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
        },
      );
    });
  }
}

/**
 * import 'package:Fahkap/components/Button/btnCatList.dart';
import 'package:Fahkap/components/Button/btnCatListPV.dart';
import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Text/bigtitleText.dart';
import 'package:Fahkap/components/Widget/categoryComponent.dart';
import 'package:Fahkap/components/Widget/productComponent.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Text/titleText.dart';
import 'package:Fahkap/controller/categoryController.dart';
import 'package:Fahkap/controller/popularproductController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(controller: _scrollController, slivers: [
      // Add the app bar to the CustomScrollView.
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
        // Use a delegate to build items as they're scrolled on screen.
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
