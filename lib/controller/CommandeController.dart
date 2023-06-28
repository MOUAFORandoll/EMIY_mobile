import 'package:EMIY/model/data/CartModel.dart';
import 'package:EMIY/model/data/CategoryModel.dart';
import 'package:EMIY/model/data/CommandeModel.dart';
import 'package:EMIY/model/data/ProduitCategoryModel.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/repository/CommandeRepo.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/utils/Services/requestServices.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:get/get.dart';

class CommandeController extends GetxController {
  final service = new ApiService();
  final CommandeRepo commandeRepo;
  CommandeController({required this.commandeRepo});
  List<CommandeModel> _commandeList = [];
  List<CommandeModel> get commandeList => _commandeList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  final dababase = Get.find<DataBaseController>();

  getListCommandes() async {
    try {
      //print('DB *************response ');
      _commandeList.clear();
      _isLoaded = false;
      var response = await dababase.getListCommande();
      //print('DB *************response ');
      //print(response);
      _commandeList.addAll(
          (response as List).map((e) => CommandeModel.fromJson(e)).toList());
      // //print(_categoryList);
      _isLoaded = true;
      update();
    } catch (e) {
      //print(e);
    }
  }

  saveCommande(id, codeCommande, codeClient, date) {
    dababase.insert(id, codeCommande, codeClient, date);
  }

  List<Produit> _produitList = [];
  List<Produit> get produitList => _produitList;
  bool _isLoadedP = false;
  bool get isLoadedP => _isLoadedP;

  var _commandeSelect;
  CommandeModel get commandeSelect => _commandeSelect;
  findComBuyId(id) {
    _commandeList.forEach((com) {
      if (com.id == id) {
        _commandeSelect = com;
      }
    });
  }

  var fn = new ViewFunctions();

  getProduitForCommandes(id) async {
    //print('*------33333333333333333333${id}');

    try {
      // fn.loading(
      //     'Commande', 'Recuperation des produits de la commande en cours');
      _isLoadedP = false;
      _produitList.clear();
      findComBuyId(id);
      Response response = await commandeRepo.getListProductForComm(id);
      //print('*------response');
      //print(response.body);
      if (response.body != null) {
        if (response.body['data'].length != 0) {
          produitList.addAll((response.body['data'] as List)
              .map((e) => Produit.fromJson(e))
              .toList());

          // fn.closeSnack();
        }
        _isLoadedP = true;
        update();
        // fn.closeSnack();
      }

      // fn.closeSnack();
    } catch (e) {
      // fn.closeSnack();

      //print(e);
    }
  }
}
