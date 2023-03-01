import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nzuri_ecommerce_app/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../colors/colors.dart';
import '../../strings/my_cart_strings.dart';
import '../home_screen/home_screen.dart';

void main() {
  runApp(const MyCartScreen());
}

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CartScreen(),
      );
    });
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final myCartProducts = context.watch<ProductProvider>().myProducts;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          backgroundColor: kBackgroundColor,
          leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomeScreen()));
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            cartAppBarTitle,
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
            padding: EdgeInsets.fromLTRB(3.w, 5.w, 3.w, 2.w),
            child: ListView.builder(
                itemCount: myCartProducts.length,
                itemBuilder: (context, index) {
                  final product = myCartProducts[index];

                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Card(
                        color: kProductCardColor,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.w)),
                        child: Padding(
                          padding: EdgeInsets.only(right: 2.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 20.w,
                                    height: 15.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.w))),
                                    child: Image.network(
                                      product.image,
                                      width: double.infinity,
                                      height: 19.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.w),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 45.w,
                                          child: Text(
                                            product.title,
                                            style: GoogleFonts.robotoSlab(
                                                color: kTextColor,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600),
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
                                            Text(product.price,
                                                style: GoogleFonts.robotoSlab(
                                                    color: kPrimaryColor,
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Text('\$',
                                                style: GoogleFonts.robotoSlab(
                                                    color: kPrimaryColor))
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: (() {
                                  context
                                      .read<ProductProvider>()
                                      .removeFromCart(product);
                                }),
                                child: Icon(
                                  Icons.delete_forever_outlined,
                                  size: 7.w,
                                  color: kPrimaryColor,
                                ),
                              )
                            ],
                          ),
                        )),
                  );
                }),
          ),
        ),
      ),
    ));
  }
}
