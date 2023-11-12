import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/utils/Services/ApiClient.dart';
import 'package:EMIY/utils/Services/storageService.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ShortRepo extends GetxService {
  final ApiClient apiClient;
  ShortRepo({required this.apiClient});

  Future getListForYouShort(indexC, keySecret) async {
    Response a = await apiClient.getData(ApiRoutes.SHORT_READ_FORYOU +
        "?page=${indexC.toString()}&keySecret=${keySecret.toString()}");

    return a;
  }

  Future getListSuivisShort(indexC, keySecret) async {
    Response a = await apiClient.getData(ApiRoutes.SHORT_READ_SUIVIS +
        "?page=${indexC.toString()}&keySecret=${keySecret.toString()}");

    return a;
  }

  Future readShort(codeShort, keySecret) async {
    Response a = await apiClient.getData(ApiRoutes.SAVE_SHORT_USER_READ +
        "?codeShort=${codeShort.toString()}&keySecret=${keySecret.toString()}");

    return a;
  }

  Future newLike(data) async {
    //print('************oc');
    Response a = await apiClient.postData(ApiRoutes.SHORT_LIKE, data);

    //print(a.body);
    return a;
  }

  Future newLikeComment(data) async {
    //print('************oc');
    Response a = await apiClient.postData(ApiRoutes.SHORT_COMMENT_LIKE, data);

    //print(a.body);
    return a;
  }

  Future newComment(data) async {
    //print('************oc');
    Response a = await apiClient.postData(ApiRoutes.SHORT_COMMENT, data);

    //print(a.body);
    return a;
  }

  Future getListComment(idShort, keySecret) async {
    Response a = await apiClient.getData(ApiRoutes.SHORT_COMMENT +
        "?idShort=${idShort.toString()}&keySecret=${keySecret.toString()}");

    return a;
  }

  Future getListShortForBoutique(codeBoutique, keySecret, page) async {
    Response a = await apiClient.getData(ApiRoutes.READ_SHORT_FOR_BOUTIQUE +
        "?codeBoutique=${codeBoutique.toString()}&keySecret=${keySecret}&page=${page}");

    return a;
  }

  Future getListCommentComment(idRef, keySecret) async {
    Response a = await apiClient.getData(ApiRoutes.SHORT_COMMENT_COMMENT +
        "?idRef=${idRef.toString()}&keySecret=${keySecret.toString()}");

    return a;
  }

  Future getUniqueShort(id, codeShort, keySecret) async {
    print((ApiRoutes.SHORT_READ_UNIQUE +
        "?id=${id.toString()}&codeShort=${codeShort.toString()}&keySecret=${keySecret.toString()}"));
    Response a = await apiClient.getData(ApiRoutes.SHORT_READ_UNIQUE +
        "?id=${id.toString()}&codeShort=${codeShort.toString()}&keySecret=${keySecret.toString()}");

    return a;
  }

  
  Future findUserBuyTag(tag) async {
    Response a = await apiClient.getData(ApiRoutes.LIST_USER_BY + '?tag=$tag');

    return a;
  }
}
