import 'package:fakestore/data/model/response/product_model.dart';
import 'package:fakestore/provider/cart_provider.dart';
import 'package:fakestore/provider/product_provider.dart';
import 'package:fakestore/screen/cart/cart_screen.dart';
import 'package:fakestore/screen/product/widget/product_widget.dart';
import 'package:fakestore/utill/color_resources.dart';
import 'package:fakestore/utill/custom_themes.dart';
import 'package:fakestore/utill/dimensions.dart';
import 'package:fakestore/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }
  _loadData(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.WHITE,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: ColorResources.WHITE,
          onRefresh: () async {
            await _loadData(context);
          },
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // App Bar
                  SliverAppBar(
                    floating: true,
                    elevation: 0,
                    centerTitle: false,
                    automaticallyImplyLeading: false,
                    backgroundColor: ColorResources.WHITE,
                    leading: Padding(
                      padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Image.asset(Images.menus, height: Dimensions.ICON_SIZE_DEFAULT),
                    ),
                    title: Center(child: Text("New Arrival", style: ubuntuSemiBold.copyWith(fontSize: 20, color: ColorResources.BLACK),)),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: IconButton(
                          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
                          },
                          icon: Stack(clipBehavior: Clip.none, children: [
                            Image.asset(
                              Images.shopping_cart,
                              height: Dimensions.ICON_SIZE_DEFAULT,
                              width: Dimensions.ICON_SIZE_DEFAULT,
                              color: ColorResources.COLOR_PRIMARY,
                            ),
                            Positioned(top: -4, right: -4,
                              child: Consumer<CartProvider>(builder: (context, cart, child) {
                                return CircleAvatar(radius: 7, backgroundColor: ColorResources.RED,
                                  child: Text(cart.cartList.length.toString(),
                                      style: ubuntuSemiBold.copyWith(color: ColorResources.WHITE, fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                      )),
                                );
                              }),
                            ),
                          ]),
                        ),
                      ),


                    ],
                  ),

                  // Search Button
                  SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverDelegate(
                          child: InkWell(
                       // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen())),
                            child: Container(padding:const EdgeInsets.symmetric(
                                horizontal: Dimensions.HOME_PAGE_PADDING, vertical: Dimensions.PADDING_SIZE_SMALL),
                              color: ColorResources.WHITE,
                              alignment: Alignment.center,
                              child: Container(padding:const EdgeInsets.only(
                                left: Dimensions.HOME_PAGE_PADDING, right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                top: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                                height: 50, alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(color: ColorResources.TEXT_FIELD_BG,
                                  borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),),
                                child: Row(mainAxisAlignment : MainAxisAlignment.spaceBetween, children: [

                                  const Icon(Icons.search, color: ColorResources.BLACK, size: Dimensions.ICON_SIZE_DEFAULT),
                                  Expanded(
                                    child: Text("Search Product...",
                                        style: ubuntuRegular.copyWith(color: Theme.of(context).hintColor)),
                                  ),


                            ]),
                          ),
                        ),
                      ))),


                  SliverToBoxAdapter(
                    child: Padding(
                      padding:const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height-120,
                        child: Consumer<ProductProvider>(
                          builder: (context, prodProvider, child) {
                            List<ProductModel> productList;
                            productList = prodProvider.productList;
                            return productList.length != 0 ?
                            ListView.builder(
                                itemCount: productList.length,
                                itemBuilder: (context, index){
                                  return ProductWidget(productModel: productList[index], index: index,);
                                })
                                :const Center(child: CircularProgressIndicator());
                          },
                        ),
                      )
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}



class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 70 || oldDelegate.minExtent != 70 || child != oldDelegate.child;
  }
}
