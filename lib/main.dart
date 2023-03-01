import 'package:flutter/material.dart';
import 'package:nzuri_ecommerce_app/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen/splash_screen.dart';

void main() {
  runApp(ChangeNotifierProvider<ProductProvider>(
    child: const MySplashScreen(),
    create: (context) => ProductProvider(),
  ));
}
