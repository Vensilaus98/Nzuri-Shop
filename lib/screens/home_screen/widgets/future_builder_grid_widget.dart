import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nzuri_ecommerce_app/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../colors/colors.dart';
import '../../../models/product_model.dart';
import '../../product_screen/product_screen.dart';
import 'loader_widget.dart';

class FutureBuilderGridWidget extends StatelessWidget {
  const FutureBuilderGridWidget(
      {Key? key, required this.products, required this.myCart})
      : super(key: key);

  final Future<List<Product>>? products;
  final List<Product> myCart;

  @override
  Widget build(BuildContext context) {
    //Create new List of Type product for sorting

    return FutureBuilder<List<Product>>(
      future: products,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data?.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 3.w,
                  mainAxisSpacing: 3.w,
                  mainAxisExtent: 35.h),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    String? title = snapshot.data![index].title;
                    String? price = snapshot.data![index].price;
                    String? description = snapshot.data![index].description;
                    String? image = snapshot.data![index].image;
                    String? rate = snapshot.data![index].rating.rate;
                    int? quantity = snapshot.data![index].rating.count;

                    //Prepare required parameters
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductScreen(
                                  productName: title,
                                  productPrice: price,
                                  productDescription: description,
                                  productImage: image,
                                  rate: rate,
                                  quantity: quantity,
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: kProductCardColor,
                        boxShadow: [
                          BoxShadow(
                              color: kBoxShadowColor,
                              blurRadius: 10,
                              spreadRadius: 3)
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(2.w)),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.network(
                              snapshot.data![index].image,
                              width: double.infinity,
                              height: 19.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(3.w, 2.w, 3.w, 2.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      snapshot.data![index].title,
                                      style: GoogleFonts.robotoSlab(
                                          color: kHeadingTextColor,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                      softWrap: false,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].price,
                                        style: GoogleFonts.robotoSlab(
                                            color: kPrimaryColor,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        '\$',
                                        style: GoogleFonts.robotoSlab(
                                            color: kPrimaryColor,
                                            fontSize: 10.sp),
                                      )
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (!myCart
                                          .contains(snapshot.data![index])) {
                                        context
                                            .read<ProductProvider>()
                                            .addToCart(snapshot.data![index]);
                                      } else {
                                        context
                                            .read<ProductProvider>()
                                            .removeFromCart(
                                                snapshot.data![index]);
                                      }
                                    },
                                    child: Icon(
                                      myCart.contains(snapshot.data![index])
                                          ? Icons.delete
                                          : Icons.shopping_bag_outlined,
                                      color: kHeadingTextColor,
                                      size: 6.w,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        } else if (snapshot.hasError) {
          return Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  style: GoogleFonts.robotoSlab(
                    color: kTextColor,
                  ),
                )
              ],
            ),
          );
        }
        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: const LoaderWidget(),
          ),
        );
      }),
    );
  }
}
