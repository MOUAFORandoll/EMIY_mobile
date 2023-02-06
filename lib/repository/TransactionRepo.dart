import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/utils/Services/ApiClient.dart';
import 'package:fahkapmobile/utils/Services/storageService.dart';
import 'package:fahkapmobile/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class TransactionRepo extends GetxService with StorageService {
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
}
