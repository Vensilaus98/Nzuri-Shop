import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../../colors/colors.dart';

class SearchAndSortingWidget extends StatelessWidget {
  final TextEditingController controller;

  const SearchAndSortingWidget({Key? key, required this.controller})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              width: 93.w,
              height: 8.h,
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  
                },
                decoration: InputDecoration(
                    focusColor: kFormInputFocusedColor,
                    prefixIcon: Icon(
                      Icons.search,
                      color: kIconsColor,
                      size: 6.w,
                    ),
                    fillColor: HexColor('#FFFFFF'),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    hintText: 'Search keyword',
                    hintStyle: GoogleFonts.robotoSlab(
                        color: kPlaceholderColor, fontSize: 12.sp)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
