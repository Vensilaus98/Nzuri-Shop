import 'package:flutter/foundation.dart';
import 'package:nzuri_ecommerce_app/services/api_call_service.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _searchedProducts = [];

  //Fetch list of products from APICallService class
  Future<List<Product>> getProducts() async {
    _products = await ApiCallService.fetchProducts();
    return _products;
  }

  //Soring list of products by Price
  Future<List<Product>> getProductsSortedByPrice() async {
    _products = await ApiCallService.fetchProducts();
    _products.sort(
        ((a, b) => double.parse(a.price).compareTo(double.parse(b.price))));
    return _products;
  }

  //Soring list of products by Rate
  Future<List<Product>> getProductsSortedByRate() async {
    _products = await ApiCallService.fetchProducts();
    _products.sort(((a, b) =>
        double.parse(a.rating.rate).compareTo(double.parse(b.rating.rate))));
    return _products;
  }

  //Searching list of products by name
  Future<List<Product>> getProductByName(String keyword) async {
    _searchedProducts = await ApiCallService.fetchProducts();
    _searchedProducts
        .where((product) =>
            product.title.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    return _searchedProducts;
  }

  //My Products in carts
  final List<Product> _myProducts = [];

  //Get my products
  List<Product> get myProducts => _myProducts;

  //Adding products to cart
  void addToCart(Product product) {
    _myProducts.add(product);
    notifyListeners();
  }

  //Remove products from cart
  void removeFromCart(Product product) {
    _myProducts.remove(product);
    notifyListeners();
  }
}
