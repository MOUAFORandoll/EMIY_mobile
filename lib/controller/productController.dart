import 'package:get/get_connect/http/src/response/response.dart';

import 'package:fahkapmobile/controller/cartController.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/repository/popularProductRepo.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;
  ProductController({required this.productRepo});

  late CartController _cart;
  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  int get totalItems {
    return _cart.totalItems;
  }

  void setQuantity(bool isIncrement) {
    print(_quantity);
    _quantity = isIncrement
        ? checkQuantity(_quantity + 1)
        : checkQuantity(_quantity - 1);
    print(_quantity);

    update();
  }

  // void setQuantityAndUp(id, bool isIncrement) {
  //   print(_quantity);
  //   _quantity = isIncrement
  //       ? checkQuantity(_quantity + 1)
  //       : checkQuantity(_quantity - 1);
  //   print(_quantity);

  //   update();
  //   _cart.updateItem(id, _quantity);
  // }

  int checkQuantity(int quantity) {
    return ((quantity + inCartItems) < 0)
        ? 0
        : ((quantity + inCartItems) > 20)
            ? 20
            : quantity;
  }

  bool exitP(ProduitModel product) {
    return _cart.existInCart(product);
  }

  void initProduct(CartController cart, ProduitModel product) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
  }

  void addItem(ProduitModel product, index, type) {
    print('quantitte : ${_quantity} total : ${_inCartItems}');
    // var sebd = _quantity < 0 ? _inCartItems - _quantity : _quantity;
    // if (_quantity > 0) {
    _cart.addItem(product, _quantity, index, type);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    // } else {
    // Get.snackbar("Add", 'E:ntrer une quantite correcte',
    //     backgroundColor: ColorsApp.grey, colorText: ColorsApp.skyBlue);
    // }
    update();
    _cart.items.forEach((k, v) {
      print('produit id : ${v.id}  quantite : ' + v.quantity.toString());
    });
  }

  List<ProduitModel> _produitList = [];
  List<ProduitModel> _produitListSave = [];
  List<ProduitModel> get produitList => _produitList;
  int _isLoadedP = 0;
  int get isLoadedP => _isLoadedP;
  Future<void> getPopularProduit() async {
    print('response**********');

    _isLoadedP = 0;
    try {
      Response response = await productRepo.getListProductPopular();

      print(response.body);

      _produitList.clear();
      if (response.body != null) {
        if (response.body['data'].length != 0) {
          _produitList.addAll((response.body['data'] as List)
              .map((e) => ProduitModel.fromJson(e))
              .toList());
          _produitListSave.addAll((response.body['data'] as List)
              .map((e) => ProduitModel.fromJson(e))
              .toList());
        }
        _isLoadedP = 1;
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  bool _searchPro = false;
  bool get searchPro => _searchPro;

  searchProButtom() {
    _searchPro = !_searchPro;
    if (!_searchPro) {
      _produitList = _produitListSave;
    }
    // searchProduit('');
    update();
  }

  searchProduit(text) {
    _produitList = [];
    List<ProduitModel> cont = [];
    print(_produitListSave);

    _produitListSave.forEach((item) {
      print(item.titre.toUpperCase());
      print(text.toUpperCase());
      if (item.titre.toUpperCase().contains(text.toUpperCase()) ||
          item.codeProduit.toUpperCase().contains(text.toUpperCase())) {
        cont.add(item);
      }
    });
    print(cont.length);
    if (cont.length != 0) {
      _produitList = cont;
    } else {
      _produitList = _produitListSave;
    }

    update();
  }
}
/**
 * import 'package:fahkapmobile/components/Button/IconButtonF.dart';
import 'package:fahkapmobile/components/Button/btnCatList.dart';
import 'package:fahkapmobile/components/Button/btnCatListPV.dart';
import 'package:fahkapmobile/components/Button/button.dart';
import 'package:fahkapmobile/components/Form/formComponent2.dart';
import 'package:fahkapmobile/components/Text/bigText.dart';
import 'package:fahkapmobile/components/Text/bigtitleText.dart';
import 'package:fahkapmobile/components/Widget/categoryComponent.dart';
import 'package:fahkapmobile/components/Widget/productComponent.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/components/Text/titleText.dart';
import 'package:fahkapmobile/components/Widget/productForBoutiqueComponent.dart';
import 'package:fahkapmobile/components/Widget/productForCatComponent.dart';
import 'package:fahkapmobile/controller/categoryController.dart';
import 'package:fahkapmobile/controller/CategoryBoutiqueController.dart';
import 'package:fahkapmobile/controller/productController.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BoutiqueView extends StatelessWidget {
  BoutiqueView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    print(Get.parameters);

    Get.find<CategoryBoutiqueController>()
        .getDataForBoutique(Get.parameters['codeBoutique']);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorsApp.black,
          ),
          onTap: () {
            Get.back();
          },
        ),
        title: BigtitleText(
            text: Get.parameters['nomBoutique'].toString(), bolder: true),
      ),
      body: GetBuilder<CategoryBoutiqueController>(
          builder: (_bscontroler) => _bscontroler.isLoadedPB == 0
              ? Shimmer.fromColors(
                  baseColor: Colors.blueGrey,
                  highlightColor: Colors.greenAccent,
                  child: SizedBox(
                    height: kMdHeight,
                    child: Stack(
                      children: [
                        GridView.builder(
                          padding: const EdgeInsets.all(20),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20.0,
                                  mainAxisSpacing: 50.0),
                          itemCount: 10,
                          itemBuilder: (_ctx, index) => Container(
                            height: kMdHeight * 2,
                            width: kMdWidth * 1.1,
                            margin: EdgeInsets.only(right: kMarginX),
                            decoration: BoxDecoration(
                                color: ColorsApp.greySecond,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      height: kMdHeight * .115,
                                      width: Get.width * .5,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage('assets/logo.png'),
                                      ))),
                                  Container(
                                    width: kSmWidth * .6,
                                    margin: EdgeInsets.only(
                                        top: Get.height * .005,
                                        left: Get.width * .008),
                                    child: Text('produit.titre',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: ColorsApp.black,
                                            fontSize: 12)),
                                  ),
                                  // Container(
                                  //   width: kSmWidth * .6,
                                  //   margin: EdgeInsets.only(
                                  //       top: Get.height * .005,
                                  //       left: Get.width * .008),
                                  //   child: Text('XAF ' + '1000',
                                  //       overflow: TextOverflow.ellipsis,
                                  //       style: TextStyle(
                                  //           color: Colors.red,
                                  //           fontSize: 12,
                                  //           fontWeight: FontWeight.bold)),
                                  // ),
                                ]),
                          ),
                        )
                      ],
                    ),
                  ))
              : _bscontroler.isLoadedPB == 1
                  ? (_bscontroler.produitBoutiqueList.length != 0)
                      ? SingleChildScrollView(
                          child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(20),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 10.0),
                              itemCount:
                                  _bscontroler.produitBoutiqueList.length,
                              itemBuilder: (_ctx, index) =>
                                  ProductForBoutiqueComponent(
                                      produit: _bscontroler
                                          .produitBoutiqueList[index],
                                      index: index)),
                        )
                      : Container(
                          height: kMdHeight * .6,
                          alignment: Alignment.center,
                          child: Center(
                            child: Text('Aucun Produit'),
                          ))
                  : Container(
                      height: kMdHeight * .6,
                      alignment: Alignment.center,
                      child: Center(
                        child: Text('Error'),
                      ))),

      // Builds 1000 ListTiles
    );
  }
}

 */