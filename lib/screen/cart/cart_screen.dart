import 'package:fakestore/data/model/response/cart_model.dart';
import 'package:fakestore/provider/cart_provider.dart';
import 'package:fakestore/screen/basewidget/custom_app_bar.dart';
import 'package:fakestore/screen/cart/widget/cart_widget.dart';
import 'package:fakestore/utill/color_resources.dart';
import 'package:fakestore/utill/custom_themes.dart';
import 'package:fakestore/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final bool fromCheckout;
  final int sellerId;
  CartScreen({this.fromCheckout = false, this.sellerId = 1});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).getCartData();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cart, child) {
      double amount = 0.0;
      double shippingAmount = 0.0;
      List<CartModel> cartList = [];
      cartList.addAll(cart.cartList);

      for (int i = 0; i < cart.cartList.length; i++) {
        amount += (cart.cartList[i].productModel!.price) * cart.cartList[i].quantity;
      }
      return Scaffold(
        bottomNavigationBar:  Container(height: 80, padding:const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,
            vertical: Dimensions.PADDING_SIZE_DEFAULT),
          decoration: BoxDecoration(color: Theme.of(context).cardColor,
            borderRadius:const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
          ),
          child: cartList.isNotEmpty ?
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Center(
                        child: Row(
                          children: [
                            Text('Total Price: ', style: ubuntuSemiBold.copyWith(
                                fontSize: Dimensions.FONT_SIZE_LARGE,),
                            ),
                            Text('\$${(amount+shippingAmount).toStringAsFixed(2)}', style: ubuntuSemiBold.copyWith(
                                color: Theme.of(context).primaryColor,fontSize: Dimensions.FONT_SIZE_LARGE, overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ))),
                Builder(
                  builder: (context) => InkWell(
                    onTap: () {
                      orderCompleteDialog(context);
                      Provider.of<CartProvider>(context, listen: false).removeCheckoutProduct(cartList);
                    },
                    child: Container(width: MediaQuery.of(context).size.width/2.5,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                              vertical: Dimensions.FONT_SIZE_SMALL),
                          child: Text('Checkout',
                              style: ubuntuSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                color: Theme.of(context).cardColor,
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ]):SizedBox(),
        ) ,
        body: ListView(
          children: [
            CustomAppBar(title: "Cart"),
            Card(
              child: Container(
                padding:const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                decoration:const BoxDecoration(
                  color: ColorResources.WHITE,
                ),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  itemCount: cartList.length,
                  itemBuilder: (context, i) {
                    return CartWidget(
                      cartModel: cartList[i],
                      index: i,
                      fromCheckout: widget.fromCheckout,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

orderCompleteDialog(BuildContext context){
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:const Text("Order Complete"),
        content:const Text("Congratulations! Your order has been successfully placed."),
        actions: <Widget>[
          TextButton(
            child:const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}