import 'package:fahkapmobile/model/data/CartModel.dart';
import 'package:fahkapmobile/model/data/CategoryModel.dart';
import 'package:fahkapmobile/model/data/CommandeModel.dart';
import 'package:fahkapmobile/model/data/ProduitCategoryModel.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/repository/CommandeRepo.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:fahkapmobile/utils/database/DataBase.dart';
import 'package:get/get.dart';

class CommandeController extends GetxController with DB {
  final service = new ApiService();
  final CommandeRepo commandeRepo;
  CommandeController({required this.commandeRepo});
  List<CommandeModel> _commandeList = [];
  List<CommandeModel> get commandeList => _commandeList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  getListCommandes() async {
    try {
      print('DB *************response ');
      _commandeList.clear();
      _isLoaded = false;
      var response = await this.getListCommande();
      print('DB *************response ');
      print(response);
      _commandeList.addAll(
          (response as List).map((e) => CommandeModel.fromJson(e)).toList());
      // print(_categoryList);
      _isLoaded = true;
      update();
    } catch (e) {
      print(e);
    }
  }

  saveCommande(id, codeCommande, codeClient, date) {
    this.insert(id, codeCommande, codeClient, date);
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

  getProduitForCommandes(id) async {
    print('*------33333333333333333333${id}');

    try {
      _isLoadedP = false;
      _produitList.clear();
      findComBuyId(id);
      Response response = await commandeRepo.getListProductForComm(id);
      print('*------response');
      print(response.body);
      if (response.body != null) {
        if (response.body['data'].length != 0) {
          produitList.addAll((response.body['data'] as List)
              .map((e) => Produit.fromJson(e))
              .toList());
        }
        _isLoadedP = true;
        update();
      }
     
    } catch (e) {
      print(e);
    }
  }
}
