import 'package:EMIY/components/Button/btnCatList.dart';
import 'package:EMIY/components/Button/btnCatListPV.dart';
import 'package:EMIY/components/Button/button.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Widget/BoxInputMessaage.dart';
import 'package:EMIY/components/Widget/CommandeComponent.dart';
import 'package:EMIY/components/Widget/OwnMessgaeCrad.dart';
import 'package:EMIY/components/Widget/ReplyCard.dart';
import 'package:EMIY/components/Widget/app_back_button.dart';
import 'package:EMIY/components/Widget/app_empty.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Widget/categoryComponent2.dart';
import 'package:EMIY/components/Widget/produitComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/controller/negociationController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class NegociationView extends StatelessWidget {
  NegociationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NegociationController>(builder: (_negociation) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: AppBackButton(),
            title: Text(
              _negociation.titreNegociation,
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(top: Get.height * .020),
                padding: EdgeInsets.only(
                    left: Get.width * .030, right: Get.width * .030),
                child: Container(
                  height: kWidth / 9,
                  width: kWidth / 9,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: _negociation.imageNegociation,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                          decoration: BoxDecoration(
                        color: ColorsApp.greySecond,
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.transparent, BlendMode.colorBurn)),
                      ));
                    },
                    placeholder: (context, url) {
                      return Container(
                        child: Center(
                            child: CircularProgressIndicator(
                          color: ColorsApp.skyBlue,
                        )),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                          height: kHeight / 4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/logo/logoNew.png'),
                          )));
                    },
                  ),
                ),
              ),
            ]),
        body: _negociation.loadNegociation == 0
            ? AppLoading()
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _negociation.listMessageNegociation.length,
                      controller: _negociation.scrollcontroller,
                      itemBuilder: (context, index) {
                        if (index ==
                            _negociation.listMessageNegociation.length) {
                          return Container(
                            height: 70,
                          );
                        }
                        if (_negociation
                                .listMessageNegociation[index].emetteurId ==
                            _negociation.idUser) {
                          return OwnMessageCard(
                            message: _negociation
                                .listMessageNegociation[index].message,
                            time: _negociation
                                .listMessageNegociation[index].heure,
                          );
                        } else {
                          return ReplyCard(
                            message: _negociation
                                .listMessageNegociation[index].message,
                            time: _negociation
                                .listMessageNegociation[index].heure,
                          );
                        }
                        // return ListTile(
                        //   title: Text(_negociation.listMessageNegociation[index]["message"],
                        //       style: TextStyle(
                        //           color: _negociation.listMessageNegociation[index]
                        //                       ["emetteurId"] ==
                        //                   _negociation.idUser
                        //               ? Colors.red
                        //               : Colors.green)),
                        // );
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       (Get.find<BoutiqueController>().Boutique != null)
                  //           ? IconButton(
                  //               icon: Icon(Icons.quora),
                  //               onPressed: () {
                  //                 _negociation.newMessageNegociation();
                  //               },
                  //             )
                  //           : Container(),
                  //       Expanded(
                  //         child: TextField(
                  //           controller: _negociation.textEditingController,
                  //           decoration: InputDecoration(
                  //             hintText: 'Entrez votre message...',
                  //           ),
                  //         ),
                  //       ),
                  //       IconButton(
                  //         icon: Icon(Icons.send),
                  //         onPressed: () {
                  //           _negociation.newMessageNegociation();
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      // height: 170,
                      // margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(color: ColorsApp.white),
                      child: BoxInputMessaage(
                        controller: _negociation.textEditingController,
                        sending: _negociation.sending,
                        onTap: () => _negociation.newMessageNegociation(),
                      ),
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
