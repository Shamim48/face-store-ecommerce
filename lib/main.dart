import 'package:fakestore/data/model/response/product_model.dart';
import 'package:fakestore/provider/cart_provider.dart';
import 'package:fakestore/provider/product_provider.dart';
import 'package:fakestore/provider/splash_provider.dart';
import 'package:fakestore/utill/color_resources.dart';
import 'package:fakestore/utill/dimensions.dart';
import 'package:fakestore/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).getProductList();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Consumer<ProductProvider>(
        builder: (context, prodProvider, child) {
      List<ProductModel> productList;
      productList = prodProvider.productList;

      return productList.length != 0 ?
      ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context, index){
            return Container(
              width: MediaQuery.of(context).size.width-40,
              alignment: Alignment.center,
              child: Column(
                children: [
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
                        image: productList[index].image,
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
                            Text(productList[index].title ?? '', textAlign: TextAlign.center,
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
                            Text(productList[index].price.toString(),
                              style: TextStyle(color: ColorResources.COLOR_PRIMARY),
                            ),



                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          })
          : Center(child: CircularProgressIndicator());

      /*Column(children: [

           productList.length != 0 ?
          Container(
            height: MediaQuery.of(context).size.width/1.44,
            child: StaggeredGridView.countBuilder(
              itemCount: productList.length,
              crossAxisCount: 2,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
              itemBuilder: (BuildContext context, int index) {
                return ProductWidget(productModel: productList[index]);
              },
            ),
          ): SizedBox.shrink() ,

        ]);*/
    },
    )
    );
  }
}
