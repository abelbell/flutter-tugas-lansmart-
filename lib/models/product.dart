// lib/models/product.dart
class Product {
  final String id;
  final String name;
  final int price;
  final String imageUrl;
  final double rating;
  final bool isPowered;
  final String category;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.isPowered,
    required this.category,
  });
}