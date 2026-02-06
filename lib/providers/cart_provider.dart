import 'package:flutter/material.dart';
import '../models/food_model.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, int> _items = {}; // productId -> quantity
  final Map<int, FoodModel> _products = {}; // productId -> product

  Map<int, int> get items => _items;

  Map<int, FoodModel> get products => _products; // ✅ PUBLIC GETTER

  int getQuantity(FoodModel food) {
    return _items[food.id] ?? 0;
  }

  void addItem(FoodModel food) {
    _products[food.id] = food;
    _items.update(food.id, (value) => value + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void removeItem(FoodModel food) {
    if (!_items.containsKey(food.id)) return;

    if (_items[food.id]! > 1) {
      _items[food.id] = _items[food.id]! - 1;
    } else {
      _items.remove(food.id);
      _products.remove(food.id);
    }
    notifyListeners();
  }

  int get totalItems => _items.values.fold(0, (sum, qty) => sum + qty);

  double get totalPrice {
    double total = 0;
    _items.forEach((id, qty) {
      total += _products[id]!.price * qty;
    });
    return total;
  }

  void clearCart() {
    _items.clear();
    _products.clear();
    notifyListeners();
  }
}
