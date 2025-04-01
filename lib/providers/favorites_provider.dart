import 'package:flutter/material.dart';
import '../models/product.dart';

class FavoritesProvider with ChangeNotifier {
  final Map<String, Product> _favorites = {};
  bool _isLoading = false;

  Map<String, Product> get favorites => {..._favorites};
  bool get isLoading => _isLoading;

  int get favoritesCount => _favorites.length;

  bool isFavorite(String productId) {
    return _favorites.containsKey(productId);
  }

  void toggleFavorite(Product product) {
    _isLoading = true;
    notifyListeners();

    if (_favorites.containsKey(product.id)) {
      _favorites.remove(product.id);
    } else {
      _favorites.putIfAbsent(product.id, () => product);
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      _isLoading = false;
      notifyListeners();
    });
  }

  void clearFavorites() {
    _favorites.clear();
    notifyListeners();
  }
}

