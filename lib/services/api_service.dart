import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../models/food_model.dart';

class ApiService {
  static const String productsUrl = 'https://api.escuelajs.co/api/v1/products';
  static const String categoriesUrl =
      'https://api.escuelajs.co/api/v1/categories';

  // ---------------- CATEGORIES ----------------
  static Future<List<CategoryModel>> fetchCategories() async {
    final response = await http.get(Uri.parse(categoriesUrl));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // ---------------- ALL PRODUCTS ----------------
  static Future<List<FoodModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(productsUrl));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => FoodModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // ---------------- PRODUCTS BY CATEGORY (FIXED) ----------------
  static Future<List<FoodModel>> getProductsByCategory(int categoryId) async {
    final response = await http.get(
      Uri.parse(
        'https://api.escuelajs.co/api/v1/categories/$categoryId/products',
      ),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => FoodModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load category products');
    }
  }
}
