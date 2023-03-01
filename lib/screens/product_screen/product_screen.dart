import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nzuri_ecommerce_app/colors/colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/products_provider.dart';
import '../../strings/my_product_strings.dart';

void main() {
  runApp(ProductScreen());
}

class ProductScreen extends StatelessWidget {

  String? productName;
  String? productPrice;
  String? productImage;
  String? productDescription;
  String? rate;
  int? quantity;

  ProductScreen(
      {super.key,
      this.productName,
      this.productPrice,
      this.productImage,
      this.productDescription,
      this.rate,
      this.quantity});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ProductDetailsPage(
            productName: productName,
            productPrice: productPrice,
            productDescription: productDescription,
            productImage: productImage,
            rate: rate,
            quantity: quantity,
          ),
        );
      },
    );
  }
}

class ProductDetailsPage extends StatefulWidget {
  final String? productName;
  final String? productPrice;
  final String? productImage;
  final String? productDescription;
  final String? rate;
  final int? quantity;

  const ProductDetailsPage(
      {super.key,
      required this.productName,
      required this.productPrice,
      required this.productImage,
      required this.productDescription,
      required this.rate,
      required this.quantity});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {

    var myProducts = context.watch<ProductProvider>().myProducts;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          backgroundColor: kBackgroundColor,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            productDetailsTitle,
            style: GoogleFonts.robotoSlab(
                color: kTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600),
          ),
          elevation: 0),
      body: SingleChildScrollView(
        child: Container(
            width: double.infinity,
            height: 100.h,
            decoration: BoxDecoration(color: kBackgroundColor),
            child: Padding(
              padding: EdgeInsets.fromLTRB(4.w, 8.w, 4.w, 2.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Product Image
                  Container(
                      width: 100.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          color: kProductCardColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child: Image.network(
                            widget.productImage!,
                            fit: BoxFit.cover,
                            width: double.maxFinite,
                          ))),

                  // Product name and description
                  SizedBox(
                    height: 2.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.productName!,
                              style: GoogleFonts.robotoSlab(
                                color: kHeadingTextColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              softWrap: false,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star_border_outlined,
                            color: kIconsColor,
                            size: 5.w,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            widget.rate!.toString(),
                            style: GoogleFonts.robotoSlab(
                                color: kIconsColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.productPrice!.toString(),
                            style: GoogleFonts.robotoSlab(
                                color: kPrimaryColor,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '\$',
                            style: GoogleFonts.robotoSlab(color: kPrimaryColor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4.w,
                      ),
                      Text(productDescription,
                          style: GoogleFonts.robotoSlab(
                              color: kHeadingTextColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 2.w),
                      Text(
                        widget.productDescription!,
                        style: GoogleFonts.robotoSlab(
                            color: kTextColor, fontSize: 10.sp),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  GestureDetector(
                    onTap: (() {}),
                    child: Container(
                      width: 100.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.w))),
                      child: Center(
                          child: Text(
                        checkoutText,
                        style: GoogleFonts.robotoSlab(
                            color: kButtonTextColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      )),
                    ),
                  )
                ],
              ),
            )),
      ),
    ));
  }
}
