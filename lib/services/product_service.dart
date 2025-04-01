import '../models/product.dart';

class ProductService {
  // Static list of products for demonstration purposes
  static List<Product> staticProducts = [
    Product(
      id: '1',
      title: 'RNTX Jersey',
      description: 'A comfortable cotton t-shirt in blue',
      price: 19.99,
      imageUrl: 'assets/images/jersey.jpg',
      category: 'Clothing',
      reviews: [],
    ),
    Product(
      id: '2',
      title: 'Airpods Pro',
      description: 'High-quality wireless headphones with noise cancellation',
      price: 99.99,
      imageUrl: 'assets/images/airpods.jpeg',
      category: 'Electronics',
      reviews: [],
    ),
    Product(
      id: '3',
      title: 'Silver Necklace',
      description: 'Elegant silver necklace with pendant',
      price: 49.99,
      imageUrl: 'assets/images/necklace.jpeg',
      category: 'Accessories',
      reviews: [],
    ),
    Product(
      id: '4',
      title: 'Denim Jeans',
      description: 'Classic denim jeans with a modern fit',
      price: 39.99,
      imageUrl: 'assets/images/jeans.jpeg',
      category: 'Clothing',
      reviews: [],
    ),
    Product(
      id: '5',
      title: 'Iphone',
      description: 'Latest model smartphone with advanced features',
      price: 699.99,
      imageUrl: 'assets/images/iphone.jpg',
      category: 'Electronics',
      reviews: [],
    ),
  ];

  // Get all products (static list)
  Future<List<Product>> getProducts() async {
    try {
      return staticProducts;
    } catch (e) {
      print('Error getting products: $e');
      return [];
    }
  }

  // Get products by category (static list filter by category)
  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      return staticProducts
          .where((product) => product.category == category)
          .toList();
    } catch (e) {
      print('Error getting products by category: $e');
      return [];
    }
  }

  // Search products (static list, simple title and description match)
  Future<List<Product>> searchProducts(String query) async {
    try {
      return staticProducts.where((product) {
        final titleMatch = product.title.toLowerCase().contains(query.toLowerCase());
        final descriptionMatch = product.description.toLowerCase().contains(query.toLowerCase());
        return titleMatch || descriptionMatch;
      }).toList();
    } catch (e) {
      print('Error searching products: $e');
      return [];
    }
  }

  // Get product by ID (static list)
  Future<Product?> getProductById(String id) async {
    try {
      // If product is not found, return null
      return staticProducts.firstWhere(
        (product) => product.id == id, 
        orElse: () => Product(
          id: '0',
          title: 'Not Found',
          description: 'Product not found',
          price: 0.0,
          imageUrl: 'https://via.placeholder.com/150',
          category: 'None',
          reviews: [],
        ),
      );
    } catch (e) {
      print('Error fetching product by ID: $e');
      return null;
    }
  }
}
