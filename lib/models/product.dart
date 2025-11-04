// lib/models/product.dart
class Product {
  final String id;
  final String name;        // Ganti title → name
  final int price;
  final String imageUrl;    // Ganti image → imageUrl
  final double rating;
  final bool isPowered;
  final String category;    // TAMBAH: untuk track_order_page

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