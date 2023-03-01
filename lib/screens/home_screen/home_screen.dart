import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nzuri_ecommerce_app/colors/colors.dart';
import 'package:nzuri_ecommerce_app/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/product_model.dart';
import '../../strings/home_strings.dart';
import 'widgets/future_builder_grid_widget.dart';
import 'widgets/loader_widget.dart';
import 'widgets/searching_sorting_widget.dart';
import 'widgets/top_bar_widget.dart';

void main() {
  runApp(const MyHomeScreen());
}

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Create search textfiled controller
  final TextEditingController _controller = TextEditingController();

  Future<List<Product>>? products;
  Future<List<Product>>? searchedProducts;

  bool isProductSortedByPrice = false;
  bool isProductSortedByRate = false;

  @override
  void initState() {
    products = Provider.of<ProductProvider>(context, listen: false).getProducts();
    super.initState();
  }

  //Create a function to call sorted products by price lists
  getSortedProductsbByPrice() {
    products = Provider.of<ProductProvider>(context, listen: false)
        .getProductsSortedByPrice();
  }

  //Create a function to call sorted products by rates lists
  getSortedProductsbByRate() {
    products = Provider.of<ProductProvider>(context, listen: false)
        .getProductsSortedByRate();
  }

  //Create a function to search for products by name
  searchProductsbByName(String title) {
    searchedProducts = Provider.of<ProductProvider>(context, listen: false)
        .getProductByName(title);
  }

  @override
  Widget build(BuildContext context) {
    var myProducts = context.watch<ProductProvider>().myProducts;

    return SafeArea(
        child: Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(color: kBackgroundColor),
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const TopBarWidget(),
                SizedBox(
                  height: 5.h,
                ),
                // SearchAndSortingWidget(controller: _controller),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        SizedBox(
                          width: 93.w,
                          height: 8.h,
                          child: TextField(
                            controller: _controller,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) {
                              setState(() {
                                searchProductsbByName(value);
                              });
                              //Open bottom sheet modal with search results
                              showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                        width: double.maxFinite,
                                        height: 80.h,
                                        decoration: BoxDecoration(
                                            color: kBackgroundColor),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              3.w, 5.w, 3.w, 2.w),
                                          child: SizedBox(
                                            width: double.maxFinite,
                                            child: FutureBuilder<List<Product>>(
                                              future: searchedProducts,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return ListView.builder(
                                                      itemCount:
                                                          snapshot.data?.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.0),
                                                          child: Card(
                                                              color:
                                                                  kProductCardColor,
                                                              elevation: 2.0,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              2.w)),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right: 2
                                                                            .w),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              20.w,
                                                                          height:
                                                                              15.h,
                                                                          decoration:
                                                                              BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.w))),
                                                                          child:
                                                                              Image.network(
                                                                            snapshot.data![index].image,
                                                                            width:
                                                                                double.infinity,
                                                                            height:
                                                                                19.h,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              3.w,
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(top: 4.w),
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              SizedBox(
                                                                                width: 45.w,
                                                                                child: Text(
                                                                                  snapshot.data![index].title,
                                                                                  style: GoogleFonts.robotoSlab(color: kTextColor, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                                  softWrap: false,
                                                                                  maxLines: 2,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 2.w,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(snapshot.data![index].price, style: GoogleFonts.robotoSlab(color: kPrimaryColor, fontSize: 15.sp, fontWeight: FontWeight.w600)),
                                                                                  SizedBox(
                                                                                    width: 1.w,
                                                                                  ),
                                                                                  Text('\$', style: GoogleFonts.robotoSlab(color: kPrimaryColor))
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          (() {
                                                                        if (!myProducts
                                                                            .contains(snapshot.data![index])) {
                                                                          context
                                                                              .read<ProductProvider>()
                                                                              .addToCart(snapshot.data![index]);
                                                                        } else {
                                                                          context
                                                                              .read<ProductProvider>()
                                                                              .removeFromCart(snapshot.data![index]);
                                                                        }
                                                                      }),
                                                                      child:
                                                                          Icon(
                                                                        myProducts.contains(snapshot.data![index])
                                                                            ? Icons.delete
                                                                            : Icons.shopping_bag_outlined,
                                                                        size:
                                                                            7.w,
                                                                        color:
                                                                            kPrimaryColor,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              )),
                                                        );
                                                      });
                                                } else if (snapshot.hasError) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 5.h),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.error_outline,
                                                          size: 5.w,
                                                          color: kIconsColor,
                                                        ),
                                                        SizedBox(
                                                          height: 1.w,
                                                        ),
                                                        Text(
                                                          'Failed to get products',
                                                          style: GoogleFonts
                                                              .robotoSlab(
                                                            color: kTextColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  return Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 5.h),
                                                      child:
                                                          const LoaderWidget(),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ));
                                  });
                            },
                            decoration: InputDecoration(
                                focusColor: kFormInputFocusedColor,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: kIconsColor,
                                  size: 6.w,
                                ),
                                fillColor: kTextColor,
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                hintText: 'Search keyword',
                                hintStyle: GoogleFonts.robotoSlab(
                                    color: kPlaceholderColor, fontSize: 12.sp)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                // Adding product categories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productTitle,
                      style: GoogleFonts.robotoSlab(
                          color: kHeadingTextColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                                height: 15.h,
                                decoration: BoxDecoration(
                                  color: kProductCardColor,
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(3.w, 5.w, 3.w, 2.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.sort,
                                            size: 7.w,
                                            color: kIconsColor,
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                getSortedProductsbByPrice();
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            child: Text(
                                              sortByPriceText,
                                              style: GoogleFonts.robotoSlab(
                                                  color: kTextColor,
                                                  fontSize: 13.sp),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.sort,
                                            size: 6.w,
                                            color: kIconsColor,
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                getSortedProductsbByRate();
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            child: Text(
                                              sortByRateText,
                                              style: GoogleFonts.robotoSlab(
                                                  color: kTextColor,
                                                  fontSize: 12.sp),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                          },
                        );
                      },
                      child: Icon(
                        Icons.sort,
                        size: 8.w,
                        color: kIconsColor,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                // Display Products by categories
                SizedBox(
                    width: double.maxFinite,
                    child: FutureBuilderGridWidget(
                        products: products, myCart: myProducts)),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
