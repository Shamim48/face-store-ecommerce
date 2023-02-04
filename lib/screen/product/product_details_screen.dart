import 'package:fakestore/data/model/response/product_model.dart';
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
          //backgroundColor: ColorResources.GREY,
          /*appBar: AppBar(
            title: Row(children: [
              InkWell(
                child: Icon(Icons.arrow_back_ios, color: Theme.of(context).cardColor, size: 20),
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text("Product Details",
                  style: ubuntuRegular.copyWith(fontSize: 20, color: Theme.of(context).cardColor)),
            ]),
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor:  Colors.black ,
          ),*/

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
                            Text("Select SIze", style: ubuntuRegular ),
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
                /*Container(
                  transform: Matrix4.translationValues(0.0, -25.0, 0.0),
                  padding: EdgeInsets.only(top: Dimensions.FONT_SIZE_DEFAULT),
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                          topRight:Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE) ),
                        ),
                  child: Column(children: [

                  Flexible(child: Text(widget.product.title, style: ubuntuSemiBold.copyWith(fontSize: 18, overflow: TextOverflow.ellipsis),)),

                  // Specification
                  (widget.product.description != null && widget.product.description.isNotEmpty) ? Container(
                    height: 158,
                    margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: Text(widget.product.description ?? '', style: ubuntuRegular.copyWith(color: Colors.black),),
                  ) : SizedBox(),

                ],),),*/
              ],
            ),
          ),
        ) : Scaffold(body: NoInternetOrDataScreen(isNoInternet: true, child: ProductDetails(product: widget.product, index: widget.index,)));

  }
}

