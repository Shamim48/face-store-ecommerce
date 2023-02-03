import 'package:fakestore/data/model/response/product_model.dart';

class CartModel {

  ProductModel? productModel;
  dynamic? quantity;

  CartModel(this.productModel, this.quantity);

  CartModel.fromJson(Map<String, dynamic> json) {
    productModel = json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    quantity = json['quantity'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.productModel;
    data['quantity'] = this.quantity;
    return data;
  }
}

