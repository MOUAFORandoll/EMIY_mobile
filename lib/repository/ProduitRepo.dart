import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/utils/Services/ApiClient.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ProduitRepo extends GetxService {
  final ApiClient apiClient;
  ProduitRepo({required this.apiClient});

  Future<Response> getListProduitPopular(indexC, keySecret) async {
    //print('get----------------');
    // try {
    Response response = await apiClient.getData(
      ApiRoutes.POPULAR_PRODUCT +
          "?page=${indexC.toString()}&keySecret=${keySecret.toString()}",
    );

    return response;
  }

  Future<Response> getListProduitBuyHomeSelect(indexC, type, keySecret) async {
    //print('get----------------');
    // try {
    Response response = await apiClient.getData(
      ApiRoutes.POPULAR_PRODUCT +
          "?page=${indexC.toString()}&keySecret=${keySecret.toString()}&type=${type.toString()}",
    );

    return response;
  }

  Future<Response> getListProduitInterest(indexC, keySecret, interest) async {
    print('get---------${interest}-------');
    // try {
    Response response = await apiClient.getData(
      ApiRoutes.INTEREST_PRODUCT +
          "?page=${indexC.toString()}&keySecret=${keySecret.toString()}&interest=$interest",
    );

    return response;
  }

  Future<Response> getListProduitPreference(indexC, keySecret) async {
    //print('get----------------');
    // try {
    Response response = await apiClient.getData(
      ApiRoutes.LIKE_PRODUIT +
          "?page=${indexC.toString()}&keySecret=${keySecret.toString()}",
    );

    return response;
  }

  Future<Response> getListProduitSupplementaire(
      codeProduit, indexC, keySecret) async {
    //print('get----------------');
    // try {
    Response response = await apiClient.getData(
      ApiRoutes.SUPPLEMENTAIRE_PRODUIT +
          "?codeProduit=$codeProduit&page=${indexC.toString()}&keySecret=${keySecret.toString()}",
    );

    return response;
  }

  Future<Response> getListProduitAll() async {
    //print('get----------------');
    // try {
    Response response = await apiClient.getData(ApiRoutes.POPULAR_ALL);

    return response;
  }
}
