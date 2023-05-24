import 'package:Fahkap/model/data/ProduitModel.dart';
import 'package:Fahkap/utils/Services/ApiClient.dart';
import 'package:Fahkap/utils/Services/storageService.dart';
import 'package:Fahkap/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class TransactionRepo extends GetxService {
  final ApiClient apiClient;
  TransactionRepo({required this.apiClient});

  Future getListTransaction(id) async {
    Response a =
        await apiClient.getCollectionsP(ApiRoutes.TRANSACTION_READ, {'id': id});

    return a;
  }

  Future retraitCompte(data) async {
    Response a =
        await apiClient.getCollectionsP(ApiRoutes.TRANSACTION_RETRAIT, data);

    return a;
  }

  Future depotCompte(data) async {
    Response a =
        await apiClient.getCollectionsP(ApiRoutes.TRANSACTION_DEPOT, data);

    return a;
  }

  Future verifyDepot(data) async {
    Response a = await apiClient.getCollectionsP(ApiRoutes.VERIFY_DEPOT, data);

    return a;
  }
}
