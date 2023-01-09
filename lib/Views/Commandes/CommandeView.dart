import 'package:fahkapmobile/components/Button/btnCatList.dart';
import 'package:fahkapmobile/components/Button/btnCatListPV.dart';
import 'package:fahkapmobile/components/Button/button.dart';
import 'package:fahkapmobile/components/Form/formComponent2.dart';
import 'package:fahkapmobile/components/Text/bigText.dart';
import 'package:fahkapmobile/components/Text/bigtitleText.dart';
import 'package:fahkapmobile/components/Widget/CommandeComponent.dart';
import 'package:fahkapmobile/components/Widget/categoryComponent.dart';
import 'package:fahkapmobile/components/Widget/categoryComponent2.dart';
import 'package:fahkapmobile/components/Widget/productComponent.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/components/Text/titleText.dart';
import 'package:fahkapmobile/controller/CommandeController.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CommandeView extends StatelessWidget {
  CommandeView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommandeController>(builder: (_commande) {
      return Scaffold(
          appBar: AppBar(
            title: BigtitleText(text: 'Commandes', bolder: true),
            centerTitle: true,
          ),
          body: CustomScrollView(controller: _scrollController, slivers: [
            SliverList(

                // Use a delegate to build items as they're scrolled on screen.
                delegate: SliverChildBuilderDelegate(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
              (context, index) => _commande.isLoaded == 0
                  ? Shimmer.fromColors(
                      baseColor: Colors.blueGrey,
                      highlightColor: Colors.greenAccent,
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: kMarginX),
                          child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (_ctx, index) => Container(
                                  height: kMdHeight / 8,
                                  // width: kMdWidth,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: kMarginX, vertical: kMarginY),
                                  decoration: BoxDecoration(
                                      color: ColorsApp.skyBlue,
                                      borderRadius: BorderRadius.circular(8)),
                                  child:
                                      /* SingleChildScrollView(
                child: */
                                      Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: kMarginX,
                                              vertical: kMarginY),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // width: kSmWidth * .6,

                                                child: Text('Code Commande : ',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: ColorsApp
                                                            .greenLight,
                                                        fontSize: 12)),
                                              ),
                                              Container(
                                                child: Text('Date : ',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ],
                                          ))
                                    ],
                                  )))))
                  : Container(
                      height: kMdHeight,
                      margin: EdgeInsets.symmetric(vertical: kMarginY * .2),
                      child: ListView.builder(
                        // scrollDirection: Axis.horizontal,
                        itemCount: _commande.commandeList.length,
                        itemBuilder: (_ctx, index) => CommandeComponent(
                          commande: _commande.commandeList[index],
                        ),
                      ),
                    ),

              childCount: 1, //_commande.commandeList.length,
            ))
          ]));
    });
  }
}
