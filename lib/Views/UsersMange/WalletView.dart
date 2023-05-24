import 'package:Fahkap/components/Widget/SelectComponent.dart';
import 'package:Fahkap/controller/ActionController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:Fahkap/components/Button/AppIconButton.dart';
import 'package:Fahkap/components/Button/IconButtonF.dart';
import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Button/customBtn.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/components/Form/text_field.dart';
import 'package:Fahkap/components/Form/textform.dart';
import 'package:Fahkap/components/Text/SimpleText.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Text/bigtitleText0.dart';
import 'package:Fahkap/components/Widget/TransactionComponent.dart';
import 'package:Fahkap/components/Widget/categoryComponent.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/controller/TransactionController.dart';
import 'package:Fahkap/controller/cartController.dart';
import 'package:Fahkap/controller/categoryController.dart';
import 'package:Fahkap/controller/categoryBoutiqueController.dart';
import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/controller/productController.dart';
import 'package:Fahkap/model/data/ProduitModel.dart';
import 'package:Fahkap/repository/TransactionRepo.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';

class WalletView extends StatelessWidget {
  WalletView({
    Key? key,
  }) : super(key: key);
  ScrollController _scrollController = new ScrollController();
  TextEditingController montant = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    var _manager = Get.find<ManagerController>();

    return GetBuilder<TransactionController>(
        builder: (transControll) => Scaffold(
            body: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Add the app bar to the CustomScrollView.
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  title: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.zero,
                          // padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(

                              // borderRadius: BorderRadius.circular(20),
                              ),
                          child: Icon(Icons.arrow_back_ios_new,
                              color: Colors.white, size: 25.0),
                        ),
                        onTap: () {
                          Get.back();
                        },
                      ),
                      Text('Mon Compte'),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.zero,
                          // padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(

                              // borderRadius: BorderRadius.circular(20),
                              ),
                          child: Icon(Icons.replay,
                              color: Colors.white, size: 25.0),
                        ),
                        onTap: () async {
                          await transControll.actualise();
                        },
                      ),
                    ],
                  )),
                  flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                          decoration: BoxDecoration(
                            gradient: GradientApp.blueG,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: kMdHeight * .08,
                                    width: kMdWidth * 1.2,
                                    // margin: EdgeInsets.symmetric(
                                    //     horizontal: kMarginX * 10),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(8),
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      //  Border.all(color: borderColor),
                                      color: Colors.white,

                                      // gradient: GradientApp.blueG,
                                    ),
                                    child: Text(
                                      'Solde : ${_manager.Compte.solde} XAF',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ]))),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30))),
                      child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'HISTORIQUE DE TRANSACTIONS',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                      margin:
                                          EdgeInsets.only(top: 2, bottom: 3),
                                      height: 3,
                                      width: kMdWidth * .5,
                                      decoration: BoxDecoration(
                                          gradient: GradientApp.blueG,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Container())
                                ])
                          ])),
                      padding: EdgeInsets.only(top: 5, bottom: 10),
                      width: double.maxFinite,
                    ),
                  ),
                  expandedHeight: 180,
                  pinned: true,
                ),
                SliverList(
                  // Use a delegate to build items as they're scrolled on screen.
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => transControll.isLoadedTrans == 0
                        ? /* Shimmer.fromColors(
                              baseColor: Colors.blueGrey,
                              highlightColor: Colors.greenAccent,
                              child: ListView.builder(
                                // scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (_ctx, x) => Container(
                                  height: kMdHeight * .13,
                                  width: kMdWidth,
                                  // padding: EdgeInsets.all(kMarginX),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: kMarginX, vertical: kMarginY),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  alignment: Alignment.center,
                                                  // margin: EdgeInsets.only(left: Get.width * .008),
                                                  child: Icon(
                                                      Icons.transit_enterexit))
                                            ]),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                // width: kSmWidth * .6,
                                                margin: EdgeInsets.only(
                                                    top: Get.height * .005,
                                                    left: Get.width * .008),
                                                child: BigtitleText0(
                                                  text: 'Transaction :  ',
                                                  bolder: true,
                                                )),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: Get.height * .005,
                                                    left: Get.width * .008),
                                                child: SimpleText(
                                                    text: 'Montant : XAF ')),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: Get.height * .005,
                                                    left: Get.width * .008),
                                                child: SimpleText(
                                                  text: 'Fait le :  ',
                                                )),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: Get.height * .005,
                                                    left: Get.width * .008),
                                                child: SimpleText(
                                                    text: 'Etat : ')),
                                            // Container(
                                            //   width: kSmWidth * .6,
                                            //   margin: EdgeInsets.only(
                                            //       top: Get.height * .005, left: Get.width * .008),
                                            //   child: Text('XAF ' + price.toString(),
                                            //       overflow: TextOverflow.ellipsis,
                                            //       style: TextStyle(
                                            //           decoration: TextDecoration.lineThrough,
                                            //           decorationColor: Colors.black,
                                            //           decorationThickness: 2.85,
                                            //           color: Colors.black,
                                            //           fontSize: 12,
                                            //           fontWeight: FontWeight.bold)),
                                            // ),
                                          ],
                                        ),
                                      ]),
                                ),
                              ))
                           */
                        SpinKitCircle(
                            color: Colors.blue,
                            size: 40,
                          )
                        : Container(
                            height: double.maxFinite,
                            margin:
                                EdgeInsets.symmetric(vertical: kMarginY * .2),
                            child: ListView.builder(
                              itemCount: transControll.transactionList.length,
                              // controller: _controller,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (_, index) => TransactionComponent(
                                transaction:
                                    transControll.transactionList[index],
                              ),
                            ),
                          ),
                    childCount: 1,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //   padding: EdgeInsets.only(
                //       left: kMdWidth / 2, right: kMdWidth / 2, top: 2, bottom: 2),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       IconButtonF(
                //         backgroundColor: ColorsApp.greenLight,
                //         icon: Icons.remove,
                //         inconSize: 15.0,
                //         onTap: () {
                //           // prod.setQuantity(false); // Get.back();
                //         },
                //       ),
                //       IconButtonF(
                //         backgroundColor: ColorsApp.greenLight,
                //         icon: Icons.add,
                //         inconSize: 15.0,
                //         onTap: () {
                //           // prod.setQuantity(true); // Get.back();
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorsApp.grey,
                  ),
                  padding: EdgeInsets.only(
                      left: kMdWidth / 6,
                      right: kMdWidth / 6,
                      top: 10,
                      bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Button(
                          borderRadius: 15.0,
                          width: Get.size.width * .4,
                          margin: EdgeInsets.only(
                              top: Get.size.height * .025, bottom: 0),
                          height: Get.size.height * .08,
                          loaderColor: Colors.white,
                          title: "Depot",
                          textColor: Colors.white,
                          itemColor: Colors.grey,
                          borderColor: Colors.transparent,
                          state: false,
                          enabled: true,
                          onTap: () async {
                            Get.bottomSheet(
                              Container(
                                height: kHeight * .7,
                                decoration: BoxDecoration(
                                    color: ColorsApp.grey,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                padding: EdgeInsets.symmetric(
                                    horizontal: kSmWidth * .07,
                                    vertical: kSmHeight * .09),
                                // height: 800,

                                child: SingleChildScrollView(
                                    child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FormComponent2(
                                        icon: Icons.money,
                                        type: 0,
                                        controller: montant,
                                        enabled: true,
                                        kType: TextInputType.number,
                                        titre: 'Montant',
                                        hint: ""),
                                    FormComponent2(
                                        icon: Icons.phone,
                                        type: 0,
                                        controller: phone,
                                        kType: TextInputType.number,
                                        enabled: true,
                                        titre: 'phone',
                                        hint: " "),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      child: Text('Moyen de recharge'),
                                    ),
                                    GetBuilder<ActionController>(
                                        builder: (_Acontroller) => Container(
                                            margin: EdgeInsets.only(
                                                // top: Get.size.height * .015,
                                                bottom: Get.size.height * .025),
                                            // decoration: BoxDecoration(
                                            //     borderRadius: BorderRadius.circular(15),
                                            //     color: Colors.white),
                                            // padding: EdgeInsets.only(
                                            //   top: 25,
                                            // ),
                                            child: Column(
                                              children: [
                                                SingleChildScrollView(
                                                    child: ListView.builder(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount: _Acontroller
                                                            .lmodePaiement
                                                            .length,
                                                        itemBuilder: (_ctx,
                                                                index) =>
                                                            SelectComponent(
                                                                select: index +
                                                                        1 ==
                                                                    _Acontroller
                                                                        .selected,
                                                                mode: _Acontroller
                                                                        .lmodePaiement[
                                                                    index])))
                                              ],
                                            ))),
                                    CustomBtn(
                                        color: ColorsApp.greenLight,
                                        title: 'Valider',
                                        onTap: () async {
                                          var _manager =
                                              Get.find<ManagerController>();
                                          var name = _manager.User.nom;
                                          var prenom =
                                              _manager.User.prenom.toString();

                                          var mode =
                                              Get.find<ActionController>()
                                                  .selected;
                                          var keySecret =
                                              await _manager.s.getKey();
                                          var data = {
                                            'keySecret': keySecret,
                                            'montant': montant.text,
                                            'numeroClient': phone.text,
                                            'nom': name,
                                            'prenom': prenom,
                                            'idModePaiement': mode
                                          };
                                          print(data);
                                          await transControll.depot(data);
                                        })
                                  ],
                                )),
                              ),
                            );
                          }),
                      Button(
                          borderRadius: 15.0,
                          width: Get.size.width * .4,
                          margin: EdgeInsets.only(
                              top: Get.size.height * .025, bottom: 0),
                          height: Get.size.height * .08,
                          loaderColor: Colors.white,
                          title: "Retirer",
                          textColor: Colors.white,
                          itemColor: Colors.grey,
                          borderColor: Colors.transparent,
                          state: false,
                          enabled: true,
                          onTap: () async {
                            Get.bottomSheet(
                              Container(
                                decoration: BoxDecoration(
                                    color: ColorsApp.grey,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                padding: EdgeInsets.symmetric(
                                    horizontal: kSmWidth * .07,
                                    vertical: kSmHeight * .09),
                                // height: 800,

                                child: SingleChildScrollView(
                                    child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FormComponent2(
                                        icon: Icons.money,
                                        type: 0,
                                        controller: montant,
                                        enabled: true,
                                        kType: TextInputType.number,
                                        titre: 'Montant',
                                        hint: ""),
                                    FormComponent2(
                                        icon: Icons.phone,
                                        type: 0,
                                        controller: phone,
                                        kType: TextInputType.number,
                                        enabled: true,
                                        titre: 'phone',
                                        hint: " "),
                                    FormComponent2(
                                        icon: Icons.lock,
                                        type: 0,
                                        controller: password,
                                        enabled: true,
                                        titre: 'password',
                                        hint: " "),
                                    CustomBtn(
                                        color: ColorsApp.greenLight,
                                        title: 'Retirer',
                                        onTap: () async {
                                          var data = {
                                            'keySecret': new GetStorage()
                                                .read('keySecret'),
                                            'montant': montant.text,
                                            'phone': phone.text,
                                          };
                                          print(data);
                                          await transControll.retrait(data);
                                        })
                                  ],
                                )),
                              ),
                            );
                          }),
                    ],
                  ),
                )
              ],
            )));
  }
}
