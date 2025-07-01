import 'dart:convert';
import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/model/productdetail_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://fakestoreapi.com/";

class ApiServices {
  Future<List<ProductModel>> getProductModel() async {
    final endPoint = "products";
    final url = "$baseUrl$endPoint";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<ProductDetailModel> getProductDetail(int productId) async {
    final endPoint = "products/$productId";
    final url = "$baseUrl$endPoint";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return ProductDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product details');
    }
  }
}