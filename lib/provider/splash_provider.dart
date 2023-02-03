import 'package:fakestore/data/repository/splash_repo.dart';
import 'package:flutter/material.dart';


class SplashProvider extends ChangeNotifier {
  final SplashRepo splashRepo;
  SplashProvider({required this.splashRepo});



  void initSharedPrefData() {
    splashRepo.initSharedData();
  }



}
