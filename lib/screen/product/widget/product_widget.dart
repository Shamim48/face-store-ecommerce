import 'package:fakestore/data/model/response/product_model.dart';
import 'package:fakestore/screen/product/product_details_screen.dart';
import 'package:fakestore/utill/custom_themes.dart';
import 'package:fakestore/utill/images.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel productModel;
  int index;
  ProductWidget({required this.productModel, required this.index});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Navigator.push(context, PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (context, anim1, anim2) => ProductDetails(product: productModel,index:  index,),
        ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width-40,
        height: MediaQuery.of(context).size.width-40,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: index%2==0 ? Colors.blue.shade50 : Colors.deepOrange.shade50,
            borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width-40,
              height: MediaQuery.of(context).size.width-135,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/1,
                    height: MediaQuery.of(context).size.width/1,
                    alignment: Alignment.center,
                    margin: index%2==0 ? EdgeInsets.only(left: 50, right: 50, top: 40, bottom: 10 ) : const EdgeInsets.only(left: 60, right: 60, top: 0, bottom: 40 ),
                    transform:  Matrix4.translationValues( 0.33, 0.33, 0.33)
                      ..rotateZ((index%2==0 ? -28 : 28) / 180),
                    decoration: BoxDecoration(
                        color: index%2==0 ? Colors.blue.shade100.withOpacity(0.6) : Colors.deepOrange.shade100.withOpacity(0.6),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    //top: 5,
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder, fit: BoxFit.cover,
                      //height: MediaQuery.of(context).size.width/1.5,
                      width: MediaQuery.of(context).size.width/2,
                      image: productModel.image,
                      imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder,
                          fit: BoxFit.cover,
                         // height: MediaQuery.of(context).size.width/1.5,
                          width: MediaQuery.of(context).size.width/2,
                      ),
                    ),)
                ],
              ),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(productModel.category, style: ubuntuRegular ),
                      Text(productModel.title, style: ubuntuSemiBold.copyWith(fontSize: 18, overflow: TextOverflow.ellipsis ), ),
                      Text("\$ ${productModel.price}", style: ubuntuSemiBold.copyWith(fontSize: 18, color: Colors.blue), ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
          ],
        ),
      ),
    );
  }
}
