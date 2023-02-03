import 'package:fakestore/data/model/response/product_model.dart';
import 'package:fakestore/utill/color_resources.dart';
import 'package:fakestore/utill/dimensions.dart';
import 'package:fakestore/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel productModel;
  ProductWidget({required this.productModel});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        /*Navigator.push(context, PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (context, anim1, anim2) => ProductDetails(product: productModel),
        ));*/
      },
      child: Container(
        height: MediaQuery.of(context).size.width/1.5,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).highlightColor,
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
        ),
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // Product Image
            Container(
              decoration: BoxDecoration(
                color: ColorResources.HINT_TEXT_COLOR,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder, fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.width/2.45,
                  image: productModel.image,
                  imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder,
                      fit: BoxFit.cover,height: MediaQuery.of(context).size.width/2.45),
                ),
              ),
            ),

            // Product Details
            Padding(
              padding: EdgeInsets.only(top :Dimensions.PADDING_SIZE_SMALL,bottom: 5, left: 5,right: 5),
              child: Container(

                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(productModel.title ?? '', textAlign: TextAlign.center,
                          style: TextStyle(fontSize: Dimensions.FONT_SIZE_SMALL,
                              fontWeight: FontWeight.w400), maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                      Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           /* RatingBar(
                              rating: double.parse(ratting),
                              size: 18,
                            ),*/




                          ]),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),


                      SizedBox(height: 2,),
                      Text(productModel.price,
                        style: TextStyle(color: ColorResources.COLOR_PRIMARY),
                      ),



                    ],
                  ),
                ),
              ),
            ),
          ]),

          // Off

          productModel.price > 0 ? Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 20,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              decoration: BoxDecoration(
                color: ColorResources.COLOR_PRIMARY,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              ),
              child: Center(
                child: Text( productModel.price,
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: Dimensions.FONT_SIZE_SMALL),
                ),
              ),
            ),
          ) : SizedBox.shrink(),

        ]),
      ),
    );
  }
}
