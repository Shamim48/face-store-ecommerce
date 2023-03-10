import 'package:fakestore/data/model/response/product_model.dart';
import 'package:fakestore/provider/product_details_provider.dart';
import 'package:fakestore/utill/color_resources.dart';
import 'package:fakestore/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductImageView extends StatelessWidget {
  final ProductModel productModel;
  int index;
  ProductImageView({required this.productModel, required this.index});

  final PageController _controller = PageController();
bool isSelect=false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            child: productModel.image != null
                ? Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: MediaQuery.of(context).size.width + 60,
                    padding:const EdgeInsets.all(10),
                    margin:const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? ColorResources.CART1_BG : ColorResources.CART2_BG,
                        borderRadius:const BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          height: MediaQuery.of(context).size.width + 30,
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 2,
                                alignment: Alignment.center,
                                margin: index % 2 == 0
                                    ? const EdgeInsets.only(
                                        left: 20,
                                        right: 80,
                                        top: 100,
                                        bottom: 80)
                                    : const EdgeInsets.only(
                                        left: 80,
                                        right: 20,
                                        top: 80,
                                        bottom: 100),
                                transform: Matrix4.translationValues(
                                    0.33, 0.33, 0.33)
                                  ..rotateZ((index % 2 == 0 ? -28 : 28) / 180),
                                decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? ColorResources.CART1_SHAPE : ColorResources.CART2_SHAPE,
                                    borderRadius:const BorderRadius.all(Radius.circular(20))),
                              ),
                              Positioned(
                                top: 50,
                                left: 20,
                                right: 20,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width - 30,
                                  child: productModel.image != null
                                      ? PageView.builder(
                                          controller: _controller,
                                          itemCount: 5,
                                          itemBuilder: (context, index) {
                                            return FadeInImage.assetNetwork(
                                              fit: BoxFit.cover,
                                              placeholder: Images.placeholder,
                                              height: MediaQuery.of(context).size.width / 2,
                                              width: MediaQuery.of(context).size.width / 2,
                                              image: '${productModel.image}',
                                              imageErrorBuilder: (c, o, s) =>
                                                  Image.asset(
                                                Images.placeholder,
                                                height: MediaQuery.of(context).size.width / 2,
                                                width: MediaQuery.of(context).size.width / 2,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          },
                                          onPageChanged: (index) {
                                            Provider.of<ProductDetailsProvider>(context, listen: false).setImageSliderSelectedIndex(index);
                                          },
                                        )
                                      : SizedBox(),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                top: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon:const Icon(
                                        Icons.arrow_back_ios_new,
                                        color: ColorResources.HINT_TEXT_COLOR,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: _indicators(context),
                                    ),
                                    Spacer(),
                                    Image.asset(
                                      Images.heart,
                                      height: 20,
                                      width: 20,
                                      color: ColorResources.HINT_TEXT_COLOR,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5,),
                      ],
                    ),
                  ) :const SizedBox(),
          ),
        ],
      ),
    );
  }

  List<Widget> _indicators(BuildContext context) {
    List<Widget> indicators = [];
    for (int index = 0; index < 5; index++) {
      indicators.add(TabPageSelectorIndicator(
        backgroundColor: index ==
                Provider.of<ProductDetailsProvider>(context).imageSliderIndex
            ? ColorResources.BLACK
            : ColorResources.HINT_TEXT_COLOR,
        borderColor: ColorResources.WHITE,
        size: index ==
                Provider.of<ProductDetailsProvider>(context).imageSliderIndex
            ? 15
            : 10,
      ));
    }
    return indicators;
  }
}
