import 'package:EMIY/components/Widget/SelectComponent.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:EMIY/components/Button/AppIconButton.dart';
import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/Button/button.dart';
import 'package:EMIY/components/Button/customBtn.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/components/Form/text_field.dart';
import 'package:EMIY/components/Form/textform.dart';
import 'package:EMIY/components/Text/SimpleText.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Text/bigtitleText0.dart';
import 'package:EMIY/components/Widget/TransactionComponent.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/controller/TransactionController.dart';
import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/controller/categoryBoutiqueController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/repository/TransactionRepo.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
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

    return GetBuilder<GeneralController>(
        builder: (generalController) => GetBuilder<TransactionController>(
            builder: (transControll) => Scaffold(
                  backgroundColor: ColorsApp.bg,
                  body: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverAppBar(
                        backgroundColor: ColorsApp.bg,
                        automaticallyImplyLeading: false,
                        title: Text(
                          'Mon Portefeuills',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Lato', fontWeight: FontWeight.w600),
                        ),
                        actions: [
                          InkWell(
                            child: Container(
                              margin: EdgeInsets.zero,
                              // padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(

                                  // borderRadius: BorderRadius.circular(20),
                                  ),
                              child: Icon(Icons.replay,
                                  color: ColorsApp.black, size: 25.0),
                            ),
                            onTap: () async {
                              await transControll.actualise();
                            },
                          ),
                        ],
                        leading: Container(
                            child: InkWell(
                          child: Container(
                            margin: EdgeInsets.zero,
                            // padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(

                                // borderRadius: BorderRadius.circular(20),
                                ),
                            child: Icon(Icons.arrow_back_ios_new,
                                color: ColorsApp.black, size: 25.0),
                          ),
                          onTap: () {
                            Get.back();
                          },
                        )),
                        flexibleSpace: FlexibleSpaceBar(
                            background: Container(
                                decoration: BoxDecoration(
                                  color: ColorsApp.bg,
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: kMarginX,
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          child: Text(
                                        'available balance',
                                        style: TextStyle(
                                          fontSize: kDescription,
                                          fontFamily: 'Lato',
                                        ),
                                      )),
                                      Container(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  child: Text(
                                                'XAF ',
                                                style: TextStyle(
                                                  fontSize: kDescription,
                                                  fontFamily: 'Lato',
                                                ),
                                              )),
                                              Container(
                                                  child: Text(
                                                _manager.Compte.solde
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: kTitle * 2.5,
                                                    fontFamily: 'Lato',
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                            ],
                                          )),
                                    ]))),
                        bottom: PreferredSize(
                            preferredSize: Size.fromHeight(180),
                            child: Container(
                              // decoration: BoxDecoration(
                              //   color: ColorsApp.grey,
                              // ),
                              margin: EdgeInsets.symmetric(
                                horizontal: kMarginX * 2,
                              ).add(
                                EdgeInsets.only(
                                    bottom: kMarginY * 2, top: kMarginY * 5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ButtonIcon(
                                      title: "Depot",
                                      textColor: ColorsApp.black,
                                      bgColor: Colors.white,
                                      icon: Icons.keyboard_arrow_down_outlined,
                                      onTap: () async {
                                        Get.bottomSheet(
                                          Container(
                                            height: kHeight * .7,
                                            decoration: BoxDecoration(
                                                color: ColorsApp.grey,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15))),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: kSmWidth * .07,
                                                vertical: kSmHeight * .09),
                                            // height: 800,

                                            child: SingleChildScrollView(
                                                child: Column(
                                              // mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FormComponent2(
                                                    icon: Icons.money,
                                                    type: 0,
                                                    // controller: .montant,
                                                    enabled: true,
                                                    kType: TextInputType.number,
                                                    titre: 'Montant',
                                                    hint: ""),
                                                FormComponent2(
                                                    icon: Icons.phone,
                                                    type: 0,
                                                    // controller: phone,
                                                    kType: TextInputType.number,
                                                    enabled: true,
                                                    titre: 'phone',
                                                    hint: " "),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child:
                                                      Text('Moyen de recharge'),
                                                ),
                                                GetBuilder<GeneralController>(
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
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemCount: _Acontroller
                                                                        .lmodePaiement
                                                                        .length,
                                                                    itemBuilder: (_ctx, index) => SelectComponent(
                                                                        select: index +
                                                                                1 ==
                                                                            generalController
                                                                                .selected,
                                                                        mode: generalController
                                                                            .lmodePaiement[index])))
                                                          ],
                                                        ))),
                                                CustomBtn(
                                                    color: ColorsApp.greenLight,
                                                    title: 'Valider',
                                                    onTap: () async {
                                                      var _manager = Get.find<
                                                          ManagerController>();
                                                      var name =
                                                          _manager.Userget.nom;
                                                      var prenom = _manager
                                                          .Userget.prenom
                                                          .toString();

                                                      var mode = Get.find<
                                                              GeneralController>()
                                                          .selected;
                                                      var keySecret =
                                                          await _manager
                                                              .dababase
                                                              .getKey();
                                                      // var data = {
                                                      //   'keySecret': keySecret,
                                                      //   'montant': montant.text,
                                                      //   'numeroClient': phone.text,
                                                      //   'nom': name,
                                                      //   'prenom': prenom,
                                                      //   'idModePaiement': mode
                                                      // };
                                                      // //print(data);
                                                      // await transControll.depot(data);
                                                    })
                                              ],
                                            )),
                                          ),
                                        );
                                      }),
                                  ButtonIcon(
                                      title: "Retirer",
                                      textColor: Colors.white,
                                      icon: Icons.keyboard_arrow_up_outlined,
                                      bgColor: Colors.black,
                                      onTap: () async {
                                        Get.bottomSheet(
                                          Container(
                                            decoration: BoxDecoration(
                                                color: ColorsApp.grey,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15))),
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
                                                    // controller: montant,
                                                    enabled: true,
                                                    kType: TextInputType.number,
                                                    titre: 'Montant',
                                                    hint: ""),
                                                FormComponent2(
                                                    icon: Icons.phone,
                                                    type: 0,
                                                    // controller: phone,
                                                    kType: TextInputType.number,
                                                    enabled: true,
                                                    titre: 'phone',
                                                    hint: " "),
                                                FormComponent2(
                                                    icon: Icons.lock,
                                                    type: 0,
                                                    // controller: password,
                                                    enabled: true,
                                                    titre: 'password',
                                                    hint: " "),
                                                CustomBtn(
                                                    color: ColorsApp.greenLight,
                                                    title: 'Retirer',
                                                    onTap: () async {
                                                      // var data = {
                                                      //   'keySecret': new GetStorage()
                                                      //       .read('keySecret'),
                                                      //   'montant': montant.text,
                                                      //   'phone': phone.text,
                                                      // };
                                                      //print(data);
                                                      // await transControll.retrait(data);
                                                    })
                                              ],
                                            )),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            )),
                        expandedHeight: 200,
                        pinned: true,
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => transControll.isLoadedTrans == 0
                              ? SpinKitCircle(
                                  color: Colors.blue,
                                  size: 40,
                                )
                              : Container(
                                  height: double.maxFinite,
                                  margin: EdgeInsets.symmetric(
                                    vertical: kMarginY * .2,
                                    horizontal: kMarginX,
                                  ),
                                  child: ListView.builder(
                                    itemCount:
                                        transControll.transactionList.length,
                                    // controller: _controller,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, index) =>
                                        TransactionComponent(
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
                )));
  }
}
