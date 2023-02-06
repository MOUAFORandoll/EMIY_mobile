import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fahkapmobile/components/Button/AppIconButton.dart';
import 'package:fahkapmobile/components/Button/IconButtonF.dart';
import 'package:fahkapmobile/components/Button/button.dart';
import 'package:fahkapmobile/components/Button/customBtn.dart';
import 'package:fahkapmobile/components/Form/formComponent2.dart';
import 'package:fahkapmobile/components/Form/text_field.dart';
import 'package:fahkapmobile/components/Form/textform.dart';
import 'package:fahkapmobile/components/Text/bigText.dart';
import 'package:fahkapmobile/components/Widget/TransactionComponent.dart';
import 'package:fahkapmobile/components/Widget/categoryComponent.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/controller/TransactionController.dart';
import 'package:fahkapmobile/controller/cartController.dart';
import 'package:fahkapmobile/controller/categoryController.dart';
import 'package:fahkapmobile/controller/categoryBoutiqueController.dart';
import 'package:fahkapmobile/controller/managerController.dart';
import 'package:fahkapmobile/controller/productController.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/repository/TransactionRepo.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/Services/routing.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CompteView extends StatelessWidget {
  CompteView({
    Key? key,
  }) : super(key: key);
  ScrollController _scrollController = new ScrollController();
  TextEditingController montant = TextEditingController();
  TextEditingController phone = TextEditingController();

  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    var _manager = Get.find<ManagerController>();

    Get.put(() => TransactionRepo(apiClient: Get.find()));
    Get.lazyPut(() => TransactionController(transactionRepo: Get.find()));
    var transControll = Get.find<TransactionController>();

    transControll.getTransactions(_manager.User.id);
    return Scaffold(
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
                      child:
                          Icon(Icons.replay, color: Colors.white, size: 25.0),
                    ),
                    onTap: () {
                      Get.back();
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
                                width: kMdWidth,
                                // margin: margin,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(8),
                                decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  //  Border.all(color: borderColor),
                                  color: Colors.white,

                                  // gradient: GradientApp.blueG,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Solde : ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${_manager.Compte.solde} XAF',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
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
                                  margin: EdgeInsets.only(top: 2, bottom: 3),
                                  height: 3,
                                  width: kMdWidth * .5,
                                  decoration: BoxDecoration(
                                      gradient: GradientApp.blueG,
                                      borderRadius: BorderRadius.circular(30)),
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
                (context, index) => Container(
                  height: double.maxFinite,
                  margin: EdgeInsets.symmetric(vertical: kMarginY * .2),
                  child: transControll.isLoadedTRans == 0
                      ? Text('Loading')
                      : ListView.builder(
                          itemCount: 1,
                          // controller: _controller,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) => Text(transControll
                              .transactionList.length
                              .toString()) /*  TransactionComponent(
                      transaction: transControll.transactionList[index],
                    ), */
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
              decoration: BoxDecoration(color: ColorsApp.grey),
              padding: EdgeInsets.only(
                  left: kMdWidth / 6, right: kMdWidth / 6, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          left: kMdWidth / 10,
                          right: kMdWidth / 10,
                          top: 10,
                          bottom: 10),
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //     color: Colors.white),
                      child: Icon(
                        FontAwesomeIcons.moneyBill,
                      )),
                  // Container(
                  //     height: Get.size.height * .08,
                  //     width: Get.size.width * .4,
                  //     child: TextFormField(
                  //       onChanged: (String value) {},
                  //       // controller: controller,
                  //       validator: (value) {
                  //         return value!.isEmpty
                  //             ? "veillez remplir se champs"
                  //             : null;
                  //       },
                  //       keyboardType: TextInputType.number,
                  //       decoration: new InputDecoration(
                  //         fillColor: ColorsApp.skyBlue,
                  //         focusedBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10.0),
                  //             borderSide: BorderSide(
                  //               color: ColorsApp.skyBlue,
                  //             )),
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(10),
                  //           borderSide: BorderSide(
                  //             color: ColorsApp.skyBlue,
                  //           ),
                  //         ),
                  //         contentPadding: EdgeInsets.only(
                  //           left: 15,
                  //           bottom: 11,
                  //           top: 15,
                  //           right: 15,
                  //         ),
                  //         // hintText: hint,
                  //         hintStyle: TextStyle(
                  //           color: Colors.grey,
                  //           fontFamily: 'orkney',
                  //         ),
                  //       ),
                  //     )),

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
                            padding: EdgeInsets.symmetric(
                                horizontal: kSmWidth * .07,
                                vertical: kSmHeight * .09),
                            // height: 800,
                            color: ColorsApp.grey,
                            child: SingleChildScrollView(
                                child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                FormComponent2(
                                    icon: Icons.account_circle,
                                    type: 0,
                                    controller: montant,
                                    enabled: true,
                                    titre: 'Montant',
                                    hint: ""),
                                FormComponent2(
                                    icon: Icons.account_circle,
                                    type: 0,
                                    controller: phone,
                                    kType: TextInputType.number,
                                    enabled: true,
                                    titre: 'phone',
                                    hint: " "),
                                CustomBtn(
                                    color: ColorsApp.greenLight,
                                    title: 'Retirer',
                                    onTap: () async {
                                      var data = {
                                        'keySecret':
                                            new GetStorage().read('keySecret'),
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
        ));
  }
}
