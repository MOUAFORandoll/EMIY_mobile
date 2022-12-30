// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahkapmobile/model/data/BoutiqueModel.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/Services/routing.dart';
import 'package:fahkapmobile/utils/api/apiUrl.dart';
import 'package:get/get.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductBoutiqueComponent extends StatelessWidget {
  Produit produit;
  var height;

  ProductBoutiqueComponent({required this.produit, this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          height: kMdHeight / 9,
          width: kMdWidth,
          margin:
              EdgeInsets.symmetric(horizontal: kMarginX, vertical: kMarginY),
          decoration: BoxDecoration(
              color: ColorsApp.skyBlue, borderRadius: BorderRadius.circular(8)),
          child: /* SingleChildScrollView(
              child: */
              Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                    child: CachedNetworkImage(
                  height: kMdHeight / 9,
                  width: Get.width / 3,
                  fit: BoxFit.cover,
                  imageUrl: produit.images[0].src,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8)),
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
                        backgroundImage: AssetImage("assets/images/error.gif"));
                  },
                )),
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: kMarginX, vertical: kMarginY),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // width: kSmWidth * .6,

                          child: Text('Nom : ' + produit.titre,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: ColorsApp.greenLight, fontSize: 12)),
                        ),
                        Container(
                          child: Text(
                              'Prix : ' + produit.prix.toString() + ' XAF',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          child: Text('Quantite : ' + produit.prix.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),
                        ),
                          Container(
                          child: Text('ajout : ' + produit.date,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),
                        ),
                        // Container(
                        //   // width: kSmWidth * .6,
                        //   child: Text('XAF ' + produit.prix.toString(),
                        //       overflow: TextOverflow.ellipsis,
                        //       style: TextStyle(
                        //           decoration: TextDecoration.lineThrough,
                        //           decorationColor: Colors.black,
                        //           decorationThickness: 2.85,
                        //           color: Colors.black,
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.bold)),
                        // )
                      ],
                    )),
              ]) /* ) */),
      onTap: () {
        // Get.toNamed(AppLinks.PRODUCT +
        //     '?index=${index}&type=0&id=${produit.id}&titre=${produit.titre}&description=${produit.description}&image=${ApiUrl.baseUrl}/images/produits/${produit.images[0].src}');
      },
    );
  }
}
