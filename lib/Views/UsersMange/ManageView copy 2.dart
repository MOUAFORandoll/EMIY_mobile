import 'dart:io';
import 'package:EMIY/Views/UsersMange/RegisterScreen.dart';
import 'package:EMIY/components/Text/TextBackSpace.dart';
import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Widget/BtnManageView.dart';
import 'package:EMIY/components/Widget/CircleImage.dart';
import 'package:EMIY/components/Widget/app_setting_comp.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/exportcomponent.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/Views/BoutiqueUser/BoutiqueUserView.dart';
import 'package:EMIY/components/Button/customBtn.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/controller/ServiceClientController.dart';
import 'package:EMIY/controller/TransactionController.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/objectbox.g.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:EMIY/views/UsersMange/LoginScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:EMIY/components/Widget/infoComponent.dart';
// import 'package:EMIY/components/informationComponent.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:shimmer/shimmer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

import '../../utils/functions/viewFunctions.dart';

// ignore: must_be_immutable
class ManageView extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagerController>(
        builder: (_manager) =>
            CustomScrollView(controller: _scrollController, slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                // floating: false,
                pinned: true,

                // snap: true,
                expandedHeight: kHeight * .35,

                bottom: PreferredSize(
                    preferredSize: Size(double.infinity, 103),
                    child: Container(
                        padding: EdgeInsets.only(top: kMarginY),
                        margin: EdgeInsets.symmetric(horizontal: kMarginX),
                        child: (_manager.Userget != null)
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    InkWell(
                                      onTap: () => _manager.updateImageUser(),
                                      child: CachedNetworkImage(
                                        height: kHeight / 10,
                                        width: kHeight / 10,
                                        fit: BoxFit.cover,
                                        imageUrl: _manager.Userget.profile,
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                        placeholder: (context, url) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: ColorsApp.greySecond,
                                            ),
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: ColorsApp.skyBlue,
                                            )),
                                          );
                                        },
                                        errorWidget: (context, url, error) {
                                          return CircleAvatar(
                                              backgroundColor:
                                                  ColorsApp.skyBlue,
                                              radius: 50,
                                              backgroundImage: AssetImage(
                                                  "assets/logo/logoNew.png"));
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            size: 18,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: kWidth * .010),
                                            child: TextBackSpace(
                                              text: _manager.Userget.phone,
                                              // bolder: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextValue(
                                              title: 'Affilies', value: 15),
                                          TextValue(
                                              title: 'Affilies', value: 15),
                                          TextValue(
                                              title: 'Affilies', value: 15),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: kMarginY),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ButtonAction(
                                                  title: 'Modifier le profil',
                                                  onTap: () {}),
                                              ButtonAction(
                                                  title: 'Parametre',
                                                  onTap: () {
                                                    Get.toNamed(
                                                        AppLinks.SETTING);
                                                  }),
                                              ButtonAction(
                                                  icon: Icons.share,
                                                  onTap: () {
                                                    Share.share(
                                                        'Inscris-toi avec mon lien et rejoins emiy : ' +
                                                            _manager
                                                                .lienParrainnage,
                                                        subject:
                                                            'Look what I made!');
                                                  }),
                                            ],
                                          ),
                                          InkWell(
                                            child: Container(
                                              width: kWidth * .5,
                                              margin: EdgeInsets.only(
                                                  top: kMarginY),
                                              padding: EdgeInsets.all(10),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: ColorsApp.red,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  kMarginX),
                                                      child: Text(
                                                        'deconnecter'.tr,
                                                        style: TextStyle(
                                                            fontFamily: 'Lato',
                                                            color:
                                                                ColorsApp.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                    Icon(Icons.logout,
                                                        color: ColorsApp.white)
                                                  ]),
                                            ),
                                            onTap: () =>
                                                _manager.deconnectUser(),
                                          )
                                        ],
                                      ),
                                    ),
                                    // Container(
                                    //     width: kWidth,
                                    //     height: kHeight * .05,
                                    //     margin: EdgeInsets.only(top: kMarginY * 2),
                                    //     child: ListView.builder(
                                    //         scrollDirection: Axis.horizontal,
                                    //         itemCount: _manager.title.length,
                                    //         itemBuilder: (ctx, i) => InkWell(
                                    //             child: Container(
                                    //                 padding: EdgeInsets.all(10),
                                    //                 margin: EdgeInsets.symmetric(
                                    //                     horizontal: kMarginX / 5),
                                    //                 decoration: BoxDecoration(
                                    //                     color: ColorsApp.greySearch,
                                    //                     borderRadius:
                                    //                         BorderRadius.circular(8)),
                                    //                 child: Text(
                                    //                   _manager.title[i].toString(),
                                    //                   style: TextStyle(
                                    //                       fontWeight: 0 == i
                                    //                           ? FontWeight.w700
                                    //                           : FontWeight.normal,
                                    //                       color: 0 == i
                                    //                           ? ColorsApp.secondBlue
                                    //                           : ColorsApp
                                    //                               .primaryBlue),
                                    //                 )),
                                    //             onTap: () {
                                    //               _manager.goToItemPage(i);
                                    //             })))
                                  ])
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: Container(
                                      constraints:
                                          BoxConstraints(maxWidth: kWidth * .4),
                                      margin: EdgeInsets.only(top: kMarginY),
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: ColorsApp.secondBlue,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        'Connectez vous',
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontFamily: 'Lato',
                                            color: ColorsApp.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    onTap: () => Get.bottomSheet(
                                      Container(
                                          margin: EdgeInsets.only(
                                            top: kMarginY * 8,
                                          ),
                                          decoration: BoxDecoration(
                                              color: ColorsApp.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight:
                                                      Radius.circular(15))),
                                          height: 800,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: kMarginX),
                                          child: Column(children: [
                                            Container(
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextButton(
                                                      child: Text('Annuler'),
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                    ),
                                                    // TextButton(
                                                    //   child: Text('Ajouter'),
                                                    //   onPressed: () async {
                                                    //     // await _controller.addShort();
                                                    //     // _controller.chageState(!_controller.addProduit);
                                                    //   },
                                                    // )
                                                  ]),
                                            ),
                                            Expanded(
                                                child: SingleChildScrollView(
                                                    child: Column(children: [
                                              // _controller.listImgProduits.length != 0
                                              //     ? smallText(
                                              //         text: 'Listes images',
                                              //       )
                                              //     : Container(),

                                              Container(
                                                  margin: EdgeInsets.only(
                                                    top: 50,
                                                  ),
                                                  child: LoginScreen())
                                            ])))
                                          ])),
                                      isScrollControlled: true,
                                    ),
                                  ),
                                  InkWell(
                                    child: Container(
                                      constraints:
                                          BoxConstraints(maxWidth: kWidth * .4),
                                      margin: EdgeInsets.only(top: kMarginY),
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: ColorsApp.greySearch,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: kMarginX),
                                              child: Text(
                                                'Inscrivez vous',
                                                style: TextStyle(
                                                    fontFamily: 'Lato',
                                                    color: ColorsApp.secondBlue,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ]),
                                    ),
                                    onTap: () => Get.bottomSheet(
                                      Container(
                                          margin: EdgeInsets.only(
                                            top: kMarginY * 8,
                                          ),
                                          decoration: BoxDecoration(
                                              color: ColorsApp.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight:
                                                      Radius.circular(15))),
                                          height: 800,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: kMarginX),
                                          child: Column(children: [
                                            Container(
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextButton(
                                                      child: Text('Annuler'),
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                    ),
                                                    // TextButton(
                                                    //   child: Text('Ajouter'),
                                                    //   onPressed: () async {
                                                    //     // await _controller.addShort();
                                                    //     // _controller.chageState(!_controller.addProduit);
                                                    //   },
                                                    // )
                                                  ]),
                                            ),
                                            Expanded(
                                                child: SingleChildScrollView(
                                                    child: Column(children: [
                                              // _controller.listImgProduits.length != 0
                                              //     ? smallText(
                                              //         text: 'Listes images',
                                              //       )
                                              //     : Container(),

                                              Container(
                                                  margin: EdgeInsets.only(
                                                    top: 0,
                                                  ),
                                                  child: RegisterScreen())
                                            ])))
                                          ])),
                                      isScrollControlled: true,
                                    ),
                                  )
                                ],
                              ))),
                flexibleSpace: (_manager.Userget != null)
                    ? InkWell(
                        child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: kMarginY * 2,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: TextBackSpace(
                                      text: _manager.Userget.prenom +
                                          ' ' +
                                          _manager.Userget.nom,
                                      bolder: true,
                                    ),
                                  ),
                                ])),
                      )
                    : Text(' '),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  constraints: BoxConstraints(minHeight: kHeight * .7),
                  // height: kHeight * .7,
                  // decoration: BoxDecoration(
                  //   color: ColorsApp.greySecond,
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  padding: EdgeInsets.symmetric(horizontal: kMarginX),
                  // margin: EdgeInsets.symmetric(
                  //     vertical: kMarginY, horizontal: kMarginX),
                  child: Container(
                      margin: EdgeInsets.only(top: kMarginY * 10),
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      child: Wrap(
                          spacing: 10,
                          alignment: WrapAlignment.center,
                          runSpacing: kMarginY * 2,
                          children: List.generate(
                              _manager.title.length,
                              (i) => i == 1 || _manager.Userget != null
                                  ? InkWell(
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: kMarginX / 5),
                                          decoration: BoxDecoration(
                                              color: ColorsApp.greySearch,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Text(
                                            _manager.title[i].toString(),
                                            style: TextStyle(),
                                          )),
                                      onTap: () {
                                        _manager.goToItemPage(i);
                                      })
                                  : Container()))),
                ),
                childCount: 1,
              )),
            ]));
  }
}

class TextValue extends StatelessWidget {
  TextValue({this.title, this.value});
  var title, value;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: kMarginY, horizontal: kMarginX),
        child: Column(
          children: [
            Container(
              child: TextBackSpace(
                text: value.toString(),
                bolder: true,
              ),
            ),
            Container(
              child: Text(title),
            ),
          ],
        ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.black,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
