import 'package:fakestore/data/datasource/remote/dio/dio_client.dart';
import 'package:fakestore/data/model/response/base/api_response.dart';
import 'package:fakestore/utill/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({required this.dioClient, required this.sharedPreferences});

  void initSharedData() async {
    if (!sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      sharedPreferences.setStringList(AppConstants.CART_LIST, []);
    }
  }

}
