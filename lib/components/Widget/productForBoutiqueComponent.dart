// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahkapmobile/model/data/BoutiqueModel.dart';
import 'package:fahkapmobile/model/data/ProduitBoutiqueModel.dart';
import 'package:fahkapmobile/model/data/ProduitCategoryModel.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/Services/routing.dart';
import 'package:fahkapmobile/utils/api/apiUrl.dart';
import 'package:get/get.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductForBoutiqueComponent extends StatelessWidget {
  ProduitModel produit;
  var height, index;

  ProductForBoutiqueComponent(
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
                    return Container(
                      child: Center(
                          child: CircularProgressIndicator(
                        color: ColorsApp.skyBlue,
                      )),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                        height: kMdHeight * .15,
                        width: Get.width * .5,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/logo.png'),
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
                        fontWeight: FontWeight.bold)),
              ),
            ]),
      ),
      onTap: () {
        // print(AppLinks.PRODUCT);

        Get.toNamed(AppLinks.PRODUCT +
            '?index=${index}&type=2&id=${produit.id}&titre=${produit.titre}&description=${produit.description}&image=${ApiUrl.baseUrl}/images/produits/${produit.images[0].src}');
      },
    );
  }
}
