// ignore: must_be_immutable
import 'package:EMIY/Views/Produit/ProduitView.dart';
import 'package:EMIY/components/Widget/ShimmerBox.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EMIY/model/data/ProduitCategoryModel.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/Services/apiUrl.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProduitForCatComponent extends StatelessWidget {
  ProduitModel produit;
  var height, index;

  ProduitForCatComponent(
      {required this.produit, required this.index, this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: kMdHeight * 25,
        width: kMdWidth * 1.1,
        // alignment: Alignment.,
        // padding: EdgeInsets.all(kMarginX),
        margin: EdgeInsets.only(right: kMarginX),
        decoration: BoxDecoration(
            color: ColorsApp.greySecond,
            borderRadius: BorderRadius.circular(8)),

        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: CachedNetworkImage(
                  height: kMdHeight * .115,
                  width: Get.width * .5,
                  fit: BoxFit.cover,
                  imageUrl: produit.images[0].src,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        color: ColorsApp.greySecond,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.transparent, BlendMode.colorBurn)),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return ShimmerBox();
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                        height: kMdHeight * .15,
                        width: Get.width * .5,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/logo/logoNew.png'),
                        )));
                  },
                ),
              ),
              Container(
                width: kSmWidth * .6,
                margin: EdgeInsets.only(
                    top: Get.height * .005, left: Get.width * .008),
                child: Text(produit.titre,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: ColorsApp.black, fontSize: 12)),
              ),
              Container(
                width: kSmWidth * .6,
                margin: EdgeInsets.only(
                    top: Get.height * .002, left: Get.width * .008),
                child: Text('XAF ' + produit.prix.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ),
            ]),
      ),
      onTap: () {
        // //print(AppLinks.PRODUCT);
        Get.to(() => ProduitView(produit: produit, index: index));
        // Get.toNamed(AppLinks.PRODUCT +
        //     '?index=${index}&type=1&codeProduit=${produit.codeProduit}&id=${produit.id}&titre=${produit.titre}&description=${produit.description}&image=${ApiUrl.baseUrl}/images/produits/${produit.images[0].src}');
      },
    );
  }
}
