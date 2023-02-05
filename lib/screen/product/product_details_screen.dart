import 'package:fakestore/data/model/response/cart_model.dart';
import 'package:fakestore/data/model/response/product_model.dart';
import 'package:fakestore/provider/cart_provider.dart';
import 'package:fakestore/provider/product_details_provider.dart';
import 'package:fakestore/screen/product/widget/product_image_view.dart';
import 'package:fakestore/utill/color_resources.dart';
import 'package:fakestore/utill/custom_themes.dart';
import 'package:fakestore/utill/dimensions.dart';
import 'package:fakestore/utill/no_internet_conection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductDetails extends StatefulWidget {
  final ProductModel product;
  int index;
  ProductDetails({required this.product, required this.index });



  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {


  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

      return widget.product!=null ? Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            CartModel cart= CartModel(widget.product, 1);
            Provider.of<CartProvider>(context, listen: false).addToCart(cart);
          },
          backgroundColor: ColorResources.BLACK,
          child: Icon(
            Icons.shopping_cart_outlined,
            size: 30,
            color: ColorResources.WHITE,
          ),
        ),

          body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                widget.product != null?
                ProductImageView(productModel: widget.product, index: widget.index,):SizedBox(),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.product.category, style: ubuntuRegular ),
                            SizedBox(height: 5,),
                            Text(widget.product.title, style: ubuntuSemiBold.copyWith(fontSize: 18, overflow: TextOverflow.ellipsis ), ),
                            SizedBox(height: 10,),
                            Text("Select Size", style: ubuntuRegular ),
                          ],
                        ),
                      ),
                      Text("\$ ${widget.product.price}",
                        style: ubuntuBold.copyWith(fontSize: 20, color: Colors.orange), ),

                    ],
                  ),
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Consumer<ProductDetailsProvider>(builder: (context, productDetails, child){
                    return productDetails.productSizeList!=null ? ListView.builder(
                        itemCount: productDetails.productSizeList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                          return InkWell(
                            onTap: (){
                              productDetails.setProductSize(index);
                            },
                            child: Container(
                              height: 40,
                              width: 50,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: productDetails.productSizeIndex==index ? Colors.orange : ColorResources.WHITE,
                                border: Border.all(
                                  width: 1,
                                  color: ColorResources.HINT_TEXT_COLOR
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              alignment: Alignment.center,
                              child: Text(productDetails.productSizeList[index].toString(), style: ubuntuRegular.copyWith(color: productDetails.productSizeIndex==index ?   ColorResources.WHITE: ColorResources.BLACK),),
                            ),
                          );
                        }): SizedBox();
                  }),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width-40,
                  decoration: BoxDecoration(
                      color:  ColorResources.GREY.withOpacity(0.5),

                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  alignment: Alignment.center,
                  child: Text("Find in Store", style: ubuntuSemiBold.copyWith(color:  ColorResources.BLACK),),
                ),
                SizedBox(height: 16,),
                SizedBox(
                  width: MediaQuery.of(context).size.width-40,
                    height: 300,
                    child: Text(widget.product.description, style: ubuntuRegular.copyWith( fontSize: 14),))
              ],
            ),
          ),
        ) : Scaffold(body: NoInternetOrDataScreen(isNoInternet: true, child: ProductDetails(product: widget.product, index: widget.index,)));

  }
}

