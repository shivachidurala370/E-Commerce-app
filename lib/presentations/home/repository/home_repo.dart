import 'package:dio/dio.dart';
import 'package:e_commerce_app/presentations/home/models/list_products_model.dart';

class HomeRepo {
  Future<List<ProductsModel>> getProducts() async {
    try {
      final response = await Dio().get('https://fakestoreapi.com/products');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((e) => ProductsModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
