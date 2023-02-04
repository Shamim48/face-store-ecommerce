import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fakestore/data/datasource/remote/dio/dio_client.dart';
import 'package:fakestore/data/datasource/remote/exception/api_error_handler.dart';
import 'package:fakestore/data/model/response/base/api_response.dart';
import 'package:fakestore/utill/app_constants.dart';
import 'package:http/http.dart' as http;

class ProductDetailsRepo {
  final DioClient dioClient;
  ProductDetailsRepo({required this.dioClient});

  Future<ApiResponse> getProduct(String productID) async {
    try {
      final response = await dioClient.get(
        AppConstants.BASE_URL+AppConstants.PRODUCTLIST+"/"+productID,);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}