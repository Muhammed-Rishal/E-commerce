import 'dart:convert';
import 'package:ecommerce/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<ProductModel>> getProductModel() async {
    final url = "https://fakestoreapi.com/products";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

}
