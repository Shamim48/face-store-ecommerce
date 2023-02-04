import 'package:fakestore/data/model/response/product_model.dart';
import 'package:fakestore/provider/product_provider.dart';
import 'package:fakestore/screen/product/widget/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body:  Consumer<ProductProvider>(
            builder: (context, prodProvider, child) {
              List<ProductModel> productList;
              productList = prodProvider.productList;
              return productList.length != 0 ?
              ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (context, index){
                   return ProductWidget(productModel: productList[index], index: index,);
                  })
                  : Center(child: CircularProgressIndicator());
            },
          )
      ),
    );
  }
}
