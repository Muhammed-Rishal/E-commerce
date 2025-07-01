import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/services/api_services.dart';
import 'package:flutter/material.dart';

import '../model/productdetail_model.dart';
class TaskProvider extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();
  List<ProductModel> _products = [];
  List<ProductDetailModel> _wishlist = [];
  List<ProductDetailModel> _cart = [];

  List<ProductModel> get products => _products;
  List<ProductDetailModel> get wishlist => _wishlist;
  List<ProductDetailModel> get cart => _cart;

  Future<void> fetchProducts() async {
    try {
      _products = await _apiServices.getProductModel();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<ProductDetailModel> getProductDetail(int productId) async {
    try {
      return await _apiServices.getProductDetail(productId);
    } catch (e) {
      throw Exception('Failed to load product details: $e');
    }
  }

  void addToWishlist(ProductDetailModel product) {
    if (!_wishlist.any((item) => item.id == product.id)) {
      _wishlist.add(product);
      notifyListeners();
    }
  }

  void removeFromWishlist(int productId) {
    _wishlist.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  void addToCart(ProductDetailModel product) {
    if (!_cart.any((item) => item.id == product.id)) {
      _cart.add(product);
      notifyListeners();
    }
  }

  void removeFromCart(int productId) {
    _cart.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  double get totalPrice {
    return _cart.fold(0, (sum, item) => sum + item.price);
  }
}