import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fakestore/data/datasource/remote/dio/dio_client.dart';
import 'package:fakestore/data/model/response/product_model.dart';
import 'package:fakestore/utill/app_constants.dart';

class ProductRepo {
  final DioClient dioClient;
  ProductRepo({required this.dioClient});

  // Products from api


  Future<List<ProductModel>> getProducts() async {
    try {
      Response response = await Dio().get(AppConstants.BASE_URL+AppConstants.PRODUCTLIST);
      List<ProductModel> products = [];
      for (var item in response.data) {
        products.add(ProductModel.fromJson(item));
      }
      return products;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return [];
    }
  }

}