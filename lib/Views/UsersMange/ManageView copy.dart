// import 'dart:convert';
// import 'dart:io';
// import 'package:Fahkap/components/Widget/BtnManageView.dart';
// import 'package:Fahkap/controller/CommandeController.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dio/dio.dart';
// import 'package:Fahkap/Views/BoutiqueUser/BoutiqueUserView.dart';
// import 'package:Fahkap/components/Button/customBtn.dart';
// import 'package:Fahkap/components/Form/formComponent2.dart';
// import 'package:Fahkap/components/Text/bigText.dart';
// import 'package:Fahkap/components/Text/smallText.dart';
// import 'package:Fahkap/controller/TransactionController.dart';
// import 'package:Fahkap/controller/boutiqueController.dart';
// import 'package:Fahkap/controller/managerController.dart';
// import 'package:Fahkap/styles/textStyle.dart';
// import 'package:Fahkap/utils/Services/routing.dart';
// import 'package:Fahkap/utils/Services/storageService2.dart';
// import 'package:Fahkap/utils/database/DataBase.dart';
// import "package:flutter/material.dart";
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import "package:font_awesome_flutter/font_awesome_flutter.dart";
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:jwt_decode/jwt_decode.dart';
// import 'package:Fahkap/components/Button/button.dart';
// import 'package:Fahkap/components/Widget/infoComponent.dart';
// // import 'package:Fahkap/components/informationComponent.dart';
// import 'package:Fahkap/styles/colorApp.dart';
// import 'package:Fahkap/utils/api/apiUrl.dart';
// import 'package:Fahkap/utils/provider/refresh_token.dart';
// import 'package:shimmer/shimmer.dart';

// import 'LoginScreen.dart';
// import 'RegisterScreen.dart';

// // ignore: must_be_immutable
// class ManageView extends StatefulWidget {
//   @override
//   _ManageViewState createState() => _ManageViewState();
// }

// class _ManageViewState extends State<ManageView> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   bool ok = false;
//   GetStorage box = GetStorage();
//   @override
//   void dispose() {
//     super.dispose();
//   }

//   ScrollController _scrollController = new ScrollController();

//   bool imgBool = true;
//   File images = File("");
// /* 
//   member membre = member(numCni: "0", cniRep: "");
//   */
//   TextEditingController _addressController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();

//   TextEditingController _newpasswordController = TextEditingController();

//   TextEditingController name = TextEditingController();
//   TextEditingController prenom = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   TextEditingController description = TextEditingController();
//   // TextEditingController adresse = TextEditingController();
//   TextEditingController email = TextEditingController();
//   bool udateAdd = false;
//   bool udatePass = false;
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return GetBuilder<ManagerController>(builder: (_manager) {
//       // _manager.initStateSign();
//       // ignore: unnecessary_null_comparison
//       if (_manager.User != null) {
//         name.text = _manager.User.nom;
//         prenom.text = _manager.User.prenom.toString();
//         phone.text = _manager.User.phone.toString();
//         email.text = _manager.User.email;
//       }
//       return CustomScrollView(controller: _scrollController, slivers: [
//         // Add the app bar to the CustomScrollView.
//         SliverAppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           automaticallyImplyLeading: false,
//           pinned: true,
//           // Provide a standard title.
//           // title: Text('title'),
//           // Allows the user to reveal the app bar if they begin scrolling
//           // back up the list of items.
//           // floating: true,
//           // Display a placeholder widget to visualize the shrinking size.
//           flexibleSpace: InkWell(
//             child: GetBuilder<BoutiqueController>(
//               builder: (_controller) => SingleChildScrollView(
//                   child: Column(children: [
//                 Container(
//                     width: 148,
//                     height: 148,
//                     decoration: BoxDecoration(
//                       color: ColorsApp.greySecond,
//                       borderRadius: BorderRadius.circular(80),
//                     ),
//                     margin: EdgeInsets.symmetric(
//                         vertical: kMarginY * 2, horizontal: kMarginX),
//                     child:
//                         Container(child: Image.asset("assets/register.png"))),
//               ])),
//             ),
//             /*   onTap: () => filterDest() */
//           ),
//           bottom: PreferredSize(
//             preferredSize: Size.fromHeight(25),
//             child: Container(
//               // padding: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
//               margin: EdgeInsets.only(top: 8),
//               decoration: BoxDecoration(
//                   color: ColorsApp.grey,
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(30),
//                       topLeft: Radius.circular(30))),
//               child: Center(
//                   child: Column(children: [
//                 // Container(
//                 //     width: 48,
//                 //     height: 48,
//                 //     margin: EdgeInsets.symmetric(
//                 //         vertical: kMarginY * 2, horizontal: kMarginX),
//                 //     child: CachedNetworkImage(
//                 //       width: 48,
//                 //       height: 48,
//                 //       fit: BoxFit.cover,
//                 //       imageUrl:
//                 //           'http://127.0.0.1:8000/images/produits/produitcmt4I.jpg',
//                 //       imageBuilder: (context, imageProvider) {
//                 //         return Container(
//                 //           decoration: BoxDecoration(
//                 //             color: ColorsApp.greySecond,
//                 //             borderRadius: BorderRadius.circular(30),
//                 //             image: DecorationImage(
//                 //                 image: imageProvider,
//                 //                 fit: BoxFit.cover,
//                 //                 colorFilter: ColorFilter.mode(
//                 //                     Colors.transparent, BlendMode.colorBurn)),
//                 //           ),
//                 //         );
//                 //       },
//                 //       placeholder: (context, url) {
//                 //         return Container(
//                 //           child: Center(
//                 //               child: CircularProgressIndicator(
//                 //             color: ColorsApp.skyBlue,
//                 //           )),
//                 //         );
//                 //       },
//                 //       errorWidget: (context, url, error) {
//                 //         return CircleAvatar(
//                 //             backgroundColor: Colors.white,
//                 //             radius: 50,
//                 //             backgroundImage:
//                 //                 AssetImage("assets/images/error.gif"));
//                 //       },
//                 //     )),

//                 GetBuilder<BoutiqueController>(
//                     builder: (_controller) => Container(
//                         // alignment: Alignment.topLeft,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
                  
//                             !_manager.userP && _manager.User != null
//                                 ? Container()
//                                 : BtnManageView(
//                                     title: "Compte",
//                                     selected: _manager.state == 0,
//                                     onTap: () => _manager.chageState(0)),
//                             !_manager.userP && _manager.User != null
//                                 ? BtnManageView(
//                                     title: "Profile",
//                                     selected: _manager.state == 1,
//                                     onTap: () => _manager.chageState(1))
//                                 : Container(),
//                             _controller.isLoaded == 1
//                                 ? _controller.isExist
//                                     ? BtnManageView(
//                                         title: "Boutique",
//                                         selected: _manager.state == 2,
//                                         onTap: () => _manager.chageState(2))
//                                     : Container()
//                                 : _controller.isLoaded == 2
//                                     ? Container()
//                                     : Container(
//                                         child: SpinKitCircle(
//                                         size: 20,
//                                         color: ColorsApp.bleuLight,
//                                       )),
//                             BtnManageView(
//                                 title: "Historique achats",
//                                 selected: _manager.state == 4,
//                                 onTap: () {
//                                   Get.find<CommandeController>()
//                                       .getListCommandes();
//                                   Get.toNamed(AppLinks.COMMANDE_FOR_USER);
//                                 }
                                
//                                 ),
//                           ],
//                         ),
//                         margin: EdgeInsets.only(
//                           top: Get.height * .030,
//                           // left: kMarginX,
//                           // right: kMarginX,
//                         ))),
//               ])),
//               // padding: EdgeInsets.only(top: 5, bottom: 10),
//               width: double.maxFinite,
//             ),
//           ),
//           // Make the initial height of the SliverAppBar larger than normal.
//           expandedHeight: 300,
//         ),
//         SliverList(
//             // Use a delegate to build items as they're scrolled on screen.
//             delegate: SliverChildBuilderDelegate(
//           // The builder function returns a ListTile with a title that
//           // displays the index of the current item.
//           (context, index) => _manager.isLoaded == 0
//               ? Shimmer.fromColors(
//                   baseColor: Colors.blueGrey,
//                   highlightColor: Colors.greenAccent,
//                   child: Container(
//                       padding: EdgeInsets.only(left: 20, right: 20, top: 20),
//                       child: Column(children: <Widget>[
//                         InfoComponent(title: Text("First name"), value: ''),
//                         InfoComponent(title: Text("Last name"), value: ''),
//                         InfoComponent(title: Text("Phone number"), value: ''),
//                         InfoComponent(title: Text("Email"), value: ''),
//                         InfoComponent(
//                           title: Row(children: [
//                             Text("Password"),
//                             // Container(
//                             //     child: Icon(FontAwesomeIcons.pen,
//                             //         size: 12, color: Color(0xFFCFD6D6)),
//                             //     margin: EdgeInsets.only(left: 10))
//                           ]),
//                           value: "*****",
//                         ),
//                         CustomBtn(
//                           color: ColorsApp.greenLight,
//                           title: 'Mettre a jour',
//                           onTap: () async {},
//                         )
//                       ])))
//               : _manager.state == 0
//                   ? Column(
//                       children: [
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Center(
//                                   child: CustomBtn(
//                                       color: _manager.stateSign
//                                           ? ColorsApp.greenLight
//                                           : ColorsApp.greySecond,
//                                       title: 'Se Connecter',
//                                       onTap: () {
//                                         _manager.steStateSign();
//                                       })),
//                               Center(
//                                 child: CustomBtn(
//                                     color: !_manager.stateSign
//                                         ? ColorsApp.greenLight
//                                         : ColorsApp.greySecond,
//                                     title: 'Creer compte',
//                                     onTap: () {
//                                       _manager.steStateSign();
//                                       print(_manager.stateSign);
//                                       // Get.toNamed(AppLinks.REGISTER);
//                                     }),
//                               )
//                             ]),
//                         // _manager.stateSign ? LoginScreen() : RegisterScreen()
//                       ],
//                     )
//                   : RefreshIndicator(
//                       color: ColorsApp.skyBlue,
//                       onRefresh: () async {
//                         await Get.find<ManagerController>().getKeyU();

//                         await Get.find<ManagerController>().getUser();

//                         await Get.find<ManagerController>().getKeyU();
//                         ;
//                       },
//                       // ignore: unnecessary_null_comparison
//                       child: _manager.state == 1
//                           ? Container(
//                               padding:
//                                   EdgeInsets.only(left: 20, right: 20, top: 10),
//                               child: Column(children: <Widget>[
//                                 InfoComponent(
//                                     title: Text("First name"),
//                                     value: _manager.User.nom),
//                                 InfoComponent(
//                                     title: Text("Last name"),
//                                     value: _manager.User.prenom),
//                                 InfoComponent(
//                                     title: Text("Phone number"),
//                                     value: _manager.User.phone),
//                                 InfoComponent(
//                                     title: Text("Email"),
//                                     value: _manager.User.email),
//                                 // InfoComponent(
//                                 //   title: Row(children: [
//                                 //     Text("Adress"),
//                                 //     Container(
//                                 //         child: Icon(FontAwesomeIcons.pen,
//                                 //             size: 12, color: Color(0xFFCFD6D6)),
//                                 //         margin: EdgeInsets.only(left: 10))
//                                 //   ]),
//                                 //   value: "addresse",
//                                 // ),
//                                 InfoComponent(
//                                   title: Row(children: [
//                                     Text("Ville"),
//                                     // Container(
//                                     //     child: Icon(FontAwesomeIcons.pen,
//                                     //         size: 12, color: Color(0xFFCFD6D6)),
//                                     //     margin: EdgeInsets.only(left: 10))
//                                   ]),
//                                   value: "*****",
//                                 ),
//                                 InkWell(
//                                   child: Container(
//                                       padding:
//                                           EdgeInsets.only(top: 2, bottom: 2),
//                                       margin:
//                                           EdgeInsets.only(bottom: 5, top: 8),
//                                       decoration:
//                                           BoxDecoration(color: ColorsApp.grey),
//                                       height: 40,
//                                       child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             smallText(
//                                                 al: true,
//                                                 width: kSmWidth,
//                                                 text: 'Gere votre compte',
//                                                 size: 16),
//                                             Container(
//                                                 margin: EdgeInsets.only(
//                                                     top: Get.height * .005,
//                                                     left: Get.width * .008),
//                                                 child: Icon(
//                                                   Icons
//                                                       .arrow_forward_ios_outlined,
//                                                   // color: Colors.white,
//                                                 )),
//                                           ])),
//                                   onTap: () {
//                                     Get.find<TransactionController>()
//                                         .getTransactions();
//                                     Get.toNamed(AppLinks.COMPTE_FOR_BOUTIQUE);
//                                   },
//                                 ),
//                                 Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             // InkWell(
//                                             //     child: Container(
//                                             //         padding: EdgeInsets.only(
//                                             //             left: 20,
//                                             //             right: 20,
//                                             //             top: 2,
//                                             //             bottom: 2),
//                                             //         // margin: EdgeInsets.only(bottom: 5, top: 8),
//                                             //         decoration: BoxDecoration(
//                                             //             color:
//                                             //                 ColorsApp.grey),
//                                             //         height: 40,
//                                             //         child: Row(
//                                             //             mainAxisAlignment:
//                                             //                 MainAxisAlignment
//                                             //                     .spaceBetween,
//                                             //             children: [
//                                             //               smallText(
//                                             //                   al: true,
//                                             //                   width: kSmWidth,
//                                             //                   text:
//                                             //                       'Historique de vos achats',
//                                             //                   size: 16),
//                                             //               Container(
//                                             //                   margin: EdgeInsets.only(
//                                             //                       top: Get.height *
//                                             //                           .005,
//                                             //                       left: Get
//                                             //                               .width *
//                                             //                           .008),
//                                             //                   child: Icon(
//                                             //                     Icons
//                                             //                         .arrow_forward_ios_outlined,
//                                             //                     // color: Colors.white,
//                                             //                   )),
//                                             //             ])),
//                                             //     onTap: () {
//                                             //       Get.find<
//                                             //               CommandeController>()
//                                             //           .getListCommandes();
//                                             //       Get.toNamed(AppLinks
//                                             //           .COMMANDE_FOR_USER);
//                                             //     }),
//                                             Container(
//                                                 margin: EdgeInsets.only(
//                                                     top: 2, bottom: 3),
//                                                 height: 3,
//                                                 width: kMdWidth * .5,
//                                                 decoration: BoxDecoration(
//                                                     gradient: GradientApp.blueG,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             30)),
//                                                 child: Container())
//                                           ])
//                                     ]),

//                                 InkWell(
//                                   child: Container(
//                                       padding:
//                                           EdgeInsets.only(top: 2, bottom: 2),
//                                       margin:
//                                           EdgeInsets.only(bottom: 5, top: 8),
//                                       decoration:
//                                           BoxDecoration(color: ColorsApp.grey),
//                                       height: 40,
//                                       child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             smallText(
//                                                 al: true,
//                                                 width: kSmWidth,
//                                                 text: 'Setting',
//                                                 size: 16),
//                                             Container(
//                                                 margin: EdgeInsets.only(
//                                                     top: Get.height * .005,
//                                                     left: Get.width * .008),
//                                                 child: Icon(
//                                                   Icons
//                                                       .arrow_forward_ios_outlined,
//                                                   // color: Colors.white,
//                                                 )),
//                                           ])),
//                                   onTap: () {
//                                     Get.toNamed(AppLinks.SETTING);
//                                   },
//                                 ),
//                                 CustomBtn(
//                                   color: ColorsApp.greenLight,
//                                   title: 'Mettre a jour',
//                                   onTap: () async {
//                                     Get.bottomSheet(
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: kSmWidth * .07,
//                                             vertical: kSmHeight * .09),
//                                         // height: 800,
//                                         decoration: BoxDecoration(
//                                             color: ColorsApp.grey,
//                                             borderRadius: BorderRadius.only(
//                                                 topLeft: Radius.circular(15),
//                                                 topRight: Radius.circular(15))),
//                                         child: SingleChildScrollView(
//                                             child: Column(
//                                           // mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             FormComponent2(
//                                                 icon: Icons.account_circle,
//                                                 type: 0,
//                                                 controller: name,
//                                                 enabled: true,
//                                                 titre: 'Nom',
//                                                 hint: ""),
//                                             FormComponent2(
//                                                 icon: Icons.account_circle,
//                                                 type: 0,
//                                                 controller: prenom,
//                                                 enabled: true,
//                                                 titre: 'Prenom',
//                                                 hint: ""),
//                                             FormComponent2(
//                                                 icon: Icons.account_circle,
//                                                 type: 0,
//                                                 controller: phone,
//                                                 kType: TextInputType.number,
//                                                 enabled: true,
//                                                 titre: 'phone',
//                                                 hint: " "),
//                                             // FormComponent2(
//                                             //     icon: Icons.account_circle,
//                                             //     type: 0,
//                                             //     controller: adresse,
//                                             //     // kType: TextInputType.number,
//                                             //     enabled: true,
//                                             //     titre: 'adresse',
//                                             //     hint: " "),
//                                             FormComponent2(
//                                                 icon: Icons.account_circle,
//                                                 type: 0,
//                                                 controller: email,
//                                                 // kType: TextInputType.number,
//                                                 enabled: true,
//                                                 titre: 'email',
//                                                 hint: " "),
//                                             CustomBtn(
//                                                 color: ColorsApp.greenLight,
//                                                 title: 'Mettre a jour',
//                                                 onTap: () async {
//                                                   var data = {
//                                                     'keySecret':
//                                                         new GetStorage()
//                                                             .read('keySecret'),
//                                                     'nom': name.text,
//                                                     'prenom': prenom.text,
//                                                     'phone': phone.text,
//                                                     'email': email.text,
//                                                   };
//                                                   print(data);
//                                                   await _manager
//                                                       .updateUser(data);
//                                                 })
//                                           ],
//                                         )),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                                 Center(
//                                     child: CustomBtn(
//                                         color: ColorsApp.red,
//                                         title: 'Deconneter',
//                                         onTap: () async {
//                                           await _manager.deconnectUser();
//                                           await _manager.deconnectUser();
//                                           print(_manager.state);
//                                           // Get.toNamed(AppLinks.LOGIN);
//                                         })),
//                               ]))
//                           : BoutiqueUserView()),

//           childCount: 1,
//         ))
//       ]);
//     });
//   }
//   // Builds 1000 ListTiles

// }
