import 'package:fakestore/data/model/response/product_model.dart';
import 'package:fakestore/provider/product_provider.dart';
import 'package:fakestore/screen/basewidget/custom_app_bar.dart';
import 'package:fakestore/screen/product/widget/product_widget.dart';
import 'package:fakestore/utill/custom_themes.dart';
import 'package:fakestore/utill/dimensions.dart';
import 'package:fakestore/utill/images.dart';
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
        appBar: buildHomeAppbar(context),
       //   CustomAppBar(title: "New Arrival", icon: Icons.shopping_cart_outlined,),
       //   const SizedBox(height: 10,),
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

buildHomeAppbar(BuildContext context) {
  return PreferredSize(child: Container(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(Images.menus),
            Text("New Arrival", style: ubuntuSemiBold,),
            Image.asset(Images.shopping_cart),
          ],
        ),
       const SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
      ],
    ),
  ), preferredSize: Size.fromHeight(100));
}
