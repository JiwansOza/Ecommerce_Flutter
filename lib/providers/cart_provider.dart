import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  bool _isLoading = false;

  Map<String, CartItem> get items => {..._items};
  bool get isLoading => _isLoading;

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.totalPrice;
    });
    return total;
  }

  void addItem(Product product) {
    _isLoading = true;
    notifyListeners();

    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingCartItem) => CartItem(
          product: existingCartItem.product,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          product: product,
        ),
      );
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      _isLoading = false;
      notifyListeners();
    });
  }

  void removeItem(String productId) {
    _isLoading = true;
    notifyListeners();

    _items.remove(productId);

    Future.delayed(const Duration(milliseconds: 500), () {
      _isLoading = false;
      notifyListeners();
    });
  }

  void removeSingleItem(String productId) {
    _isLoading = true;
    notifyListeners();

    if (!_items.containsKey(productId)) {
      _isLoading = false;
      notifyListeners();
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          product: existingCartItem.product,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      _isLoading = false;
      notifyListeners();
    });
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

