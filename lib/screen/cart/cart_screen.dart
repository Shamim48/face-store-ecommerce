import 'package:fakestore/data/model/response/cart_model.dart';
import 'package:fakestore/provider/cart_provider.dart';
import 'package:fakestore/screen/basewidget/custom_app_bar.dart';
import 'package:fakestore/screen/cart/widget/cart_widget.dart';
import 'package:fakestore/utill/color_resources.dart';
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
      double discount = 0.0;
      double tax = 0.0;
      List<CartModel> cartList = [];
      cartList.addAll(cart.cartList);

      for (int i = 0; i < cart.cartList.length; i++) {
        amount +=
            (cart.cartList[i].productModel!.price) * cart.cartList[i].quantity;
        discount += 0 * cart.cartList[i].quantity;
        tax += 15 * cart.cartList[i].quantity;
      }

      return Scaffold(
        /*bottomNavigationBar: (!widget.fromCheckout && !cart.isLoading)
            ? Container(height: 80, padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,
            vertical: Dimensions.PADDING_SIZE_DEFAULT),

          decoration: BoxDecoration(color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
          ),
          child: cartList.isNotEmpty ?
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Center(
                        child: Row(
                          children: [
                            Text('${getTranslated('total_price', context)}', style: titilliumSemiBold.copyWith(
                                fontSize: Dimensions.FONT_SIZE_LARGE),
                            ),
                            Text(PriceConverter.convertPrice(context, amount+shippingAmount), style: titilliumSemiBold.copyWith(
                                color: Theme.of(context).primaryColor,fontSize: Dimensions.FONT_SIZE_LARGE),
                            ),
                          ],
                        ))),
                Builder(
                  builder: (context) => InkWell(
                    onTap: () {
                      print('===asd=>${orderTypeShipping.length}');
                      if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                        if (cart.cartList.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('select_at_least_one_product', context)), backgroundColor: Colors.red,));
                        } else if(cart.chosenShippingList.length < orderTypeShipping.length &&
                            Provider.of<SplashProvider>(context,listen: false).configModel.shippingMethod =='sellerwise_shipping'){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('select_all_shipping_method', context)), backgroundColor: Colors.red));
                        }else if(cart.chosenShippingList.length < 1 &&
                            Provider.of<SplashProvider>(context,listen: false).configModel.shippingMethod !='sellerwise_shipping' && Provider.of<SplashProvider>(context,listen: false).configModel.inHouseSelectedShippingType =='order_wise'){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('select_all_shipping_method', context)), backgroundColor: Colors.red));
                        }


                        else {

                          Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(
                            cartList: cartList,totalOrderAmount: amount,shippingFee: shippingAmount, discount: discount,
                            tax: tax,
                          )));

                        }
                      } else {showAnimatedDialog(context, GuestDialog(), isFlip: true);}
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
                          child: Text(getTranslated('checkout', context),
                              style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                color: Theme.of(context).cardColor,
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ]):SizedBox(),
        )
            : null,*/
        body: Column(
          children: [
            CustomAppBar(title: "Cart"),
            Card(
              child: Container(
                padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
                decoration: BoxDecoration(
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
