// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/Services/routing.dart';
import 'package:fahkapmobile/utils/api/apiUrl.dart';
import 'package:get/get.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductComponent extends StatelessWidget {
  ProduitModel produit;
  var height, index;

  ProductComponent({required this.produit, required this.index, this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          height: kMdHeight * 2,
          width: kMdWidth * 1.1,
          // padding: EdgeInsets.all(kMarginX),
          margin: EdgeInsets.only(right: kMarginX),
          decoration: BoxDecoration(
              color: ColorsApp.greySecond,
              borderRadius: BorderRadius.circular(8)),
          child: /* SingleChildScrollView(
              child: */
              Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: ColorsApp.greySecond,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CachedNetworkImage(
                          height: kMdHeight * .15,
                          width: Get.width * .5,
                          fit: BoxFit.cover,
                          imageUrl: produit.images[0].src,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.red, BlendMode.colorBurn)),
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
                            return CircleAvatar(
                                backgroundColor: ColorsApp.skyBlue,
                                radius: 50,
                                backgroundImage:
                                    AssetImage("assets/images/error.gif"));
                          },
                        )),
                    // Positioned(
                    //   top: 0,
                    //   left: Get.height * .158,
                    //   child: Container(
                    //     padding: EdgeInsets.all(6),
                    //     decoration: BoxDecoration(
                    //         gradient: GradientApp.blueG,
                    //         borderRadius: BorderRadius.only(
                    //             bottomLeft: Radius.circular(10),
                    //             topRight: Radius.circular(10))),
                    //     child: Icon(Icons.shopping_cart_outlined,
                    //         color: Colors.red),
                    //   ),
                    // )
                  ],
                ),
                Container(
                  width: kSmWidth * .6,
                  margin: EdgeInsets.only(
                      top: Get.height * .005, left: Get.width * .008),
                  child: Text(produit.titre,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(color: ColorsApp.greenLight, fontSize: 12)),
                ),
                Container(
                  width: kSmWidth * .6,
                  margin: EdgeInsets.only(
                      top: Get.height * .005, left: Get.width * .008),
                  child: Text('XAF ' + produit.prix.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: kSmWidth * .6,
                  margin: EdgeInsets.only(
                      top: Get.height * .005, left: Get.width * .008),
                  child: Text('XAF ' + produit.prix.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.black,
                          decorationThickness: 2.85,
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
              ]) /* ) */),
      onTap: () {
        Get.toNamed(AppLinks.PRODUCT +
            '?index=${index}&type=0&id=${produit.id}&titre=${produit.titre}&description=${produit.description}&image=${ApiUrl.baseUrl}/images/produits/${produit.images[0].src}');
      },
    );
  }
}
