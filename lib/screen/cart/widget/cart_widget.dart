import 'package:fakestore/data/model/response/cart_model.dart';
import 'package:fakestore/provider/cart_provider.dart';
import 'package:fakestore/utill/color_resources.dart';
import 'package:fakestore/utill/custom_themes.dart';
import 'package:fakestore/utill/dimensions.dart';
import 'package:fakestore/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatelessWidget {
  final CartModel cartModel;
  final int index;
  final bool fromCheckout;
  const CartWidget(
      {required this.cartModel,
      required this.index,
      required this.fromCheckout});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      padding:const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius:const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: ColorResources.BLACK.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3
          )
        ]
      ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding:const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: ColorResources.WHITE,
                  borderRadius: BorderRadius.circular(
                      Dimensions.PADDING_SIZE_SMALL),
                  boxShadow: [
                    BoxShadow(
                      color: ColorResources.BLACK.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3
                    )
                  ]
              ),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  height: 65,
                  width: 65,
                  image: '${cartModel.productModel!.image}',
                  imageErrorBuilder: (c, o, s) => Image.asset(
                      Images.placeholder,
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding:const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(cartModel.productModel!.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: ubuntuBold.copyWith(
                              fontSize: Dimensions.FONT_SIZE_DEFAULT,
                              color: ColorResources.REVIEW_RATING,
                            )),
                      ),
                      const SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                      !fromCheckout
                          ? InkWell(
                              onTap: () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .removeFromCart(index);
                              },
                              child: Container(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    Images.delete,
                                    scale: .5,
                                  )),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                  Row(
                    children: [
                      Text("\$${cartModel.productModel!.price-5}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: ubuntuBold.copyWith(
                          color: ColorResources.RED,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: Dimensions.FONT_SIZE_DEFAULT,),
                      Text(
                        "\$${cartModel.productModel!.price}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: ubuntuRegular.copyWith(
                            color: ColorResources.COLOR_PRIMARY,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                      ),
                    ],
                  ),
                  const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                  Row(
                    children: [
                      Expanded(child: Text(cartModel.productModel!.category, style: ubuntuRegular.copyWith(
                        overflow: TextOverflow.ellipsis, ),)),
                      Padding(
                        padding:const EdgeInsets.only(
                            right: Dimensions.PADDING_SIZE_SMALL),
                        child: QuantityButton(
                            isIncrement: false,
                            index: index,
                            quantity: cartModel.quantity,
                            maxQty: 20,
                            cartModel: cartModel),
                      ),
                      Text(cartModel.quantity.toString(), style: ubuntuBold),
                      Padding(
                        padding:const EdgeInsets.only(
                            left: Dimensions.PADDING_SIZE_SMALL),
                        child: QuantityButton(
                            index: index,
                            isIncrement: true,
                            quantity: cartModel.quantity,
                            maxQty: 20,
                            cartModel: cartModel),
                      ),
                    ],
                  )
                ],
              ),
            ))
          ]),
    );
  }
}

class QuantityButton extends StatelessWidget {
  final CartModel cartModel;
  final bool isIncrement;
  final int quantity;
  final int index;
  final int maxQty;
  QuantityButton(
      {required this.isIncrement,
      required this.quantity,
      required this.index,
      required this.maxQty,
      required this.cartModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isIncrement && quantity > 1) {
          Provider.of<CartProvider>(context, listen: false)
              .setQuantity(false, index);
        } else if (isIncrement && quantity < maxQty) {
          Provider.of<CartProvider>(context, listen: false)
              .setQuantity(true, index);
        }
      },
      child: Icon(
        isIncrement ? Icons.add_circle : Icons.remove_circle,
        color: isIncrement
            ? quantity >= maxQty
                ? ColorResources.GREY
                : ColorResources.COLOR_PRIMARY
            : quantity > 1
                ? ColorResources.COLOR_PRIMARY
                : ColorResources.GREY,
        size: 30,
      ),
    );
  }
}
