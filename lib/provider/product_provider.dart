import 'package:fakestore/data/model/response/product_model.dart';
import 'package:fakestore/data/repository/product_repo.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepo productRepo;
  ProductProvider({required this.productRepo});

  List<ProductModel> _productList=[];
  List<ProductModel> get productList=>_productList;



  void getProductList() async {
    _productList.clear();
    _productList= await productRepo.getProducts();
    print("Product:");
    print(_productList.length);
    print(_productList);
    notifyListeners();
  }

}
