// lib/screens/wishlist/wishlist_page.dart
import 'package:flutter/material.dart';
import '../cart/cart_page.dart'; // BENAR: path relatif
import '../../models/product.dart'; // Import model
import '../../widgets/custom/lens_chip.dart';
import '../../widgets/custom/custom_bottom_nav.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key); // Fix super.key

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  int _currentIndex = 1;
  String selectedCategory = 'All';

  // PERBAIKAN: TAMBAH `category` DI SETIAP Product()
  List<Product> products = [
    Product(
      id: '1',
      name: 'Silver Purple Full Rim Cat Eye',
      price: 1100,
      imageUrl: 'assets/images/product1.png',
      rating: 4.8,
      isPowered: false,
      category: 'Women', // TAMBAH: untuk filter
    ),
    Product(
      id: '2',
      name: 'Silver Purple Full Rim Cat Eye',
      price: 1100,
      imageUrl: 'assets/images/product2.png',
      rating: 4.8,
      isPowered: false,
      category: 'Women', // TAMBAH: untuk filter
    ),
    Product(
      id: '3',
      name: 'Silver Purple Full Rim Cat Eye',
      price: 1100,
      imageUrl: 'assets/images/product3.png',
      rating: 4.8,
      isPowered: true,
      category: 'Women', // TAMBAH: untuk filter
    ),
    Product(
      id: '4',
      name: 'Silver Purple Full Rim Cat Eye',
      price: 1100,
      imageUrl: 'assets/images/product4.png',
      rating: 4.8,
      isPowered: true,
      category: 'Men', // TAMBAH: untuk filter
    ),
    Product(
      id: '5',
      name: 'Silver Purple Full Rim Cat Eye',
      price: 1100,
      imageUrl: 'assets/images/product6.png',
      rating: 4.8,
      isPowered: false,
      category: 'Unisex', // TAMBAH: untuk filter
    ),
    Product(
      id: '6',
      name: 'Silver Purple Full Rim Cat Eye',
      price: 1100,
      imageUrl: 'assets/images/product7.png',
      rating: 4.8,
      isPowered: true,
      category: 'Child', // TAMBAH: untuk filter
    ),
    Product(
      id: '7',
      name: 'Silver Purple Full Rim Cat Eye',
      price: 1100,
      imageUrl: 'assets/images/product8.png',
      rating: 4.8,
      isPowered: false,
      category: 'Dress', // TAMBAH: untuk filter
    ),
    Product(
      id: '8',
      name: 'Silver Purple Full Rim Cat Eye',
      price: 1100,
      imageUrl: 'assets/images/product9.png',
      rating: 4.8,
      isPowered: false,
      category: 'Women', // TAMBAH: untuk filter
    ),
  ];

  void _removeFromWishlist(int index) {
    final removedProduct = products[index];
    setState(() {
      products.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedProduct.name} removed from wishlist'),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }

  int get totalPrice {
    return products.fold(0, (sum, p) => sum + p.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Wishlist',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Row(
              children: [
                Text(
                  '${products.length} Items',
                  style: const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.fiber_manual_record, color: Colors.black87, size: 6),
                const SizedBox(width: 6),
                const Text('Total: ', style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w500)),
                Text(
                  '\$$totalPrice', // Fix: string interpolation
                  style: const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Colors.black, size: 28), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Category Buttons
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[200]!, width: 1)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _chip('All'),
                  const SizedBox(width: 8),
                  _chip('Child'),
                  const SizedBox(width: 8),
                  _chip('Men'),
                  const SizedBox(width: 8),
                  _chip('Women'),
                  const SizedBox(width: 8),
                  _chip('Dress'),
                  const SizedBox(width: 8),
                  _chip('unisex'),
                ],
              ),
            ),
          ),

          // Grid Produk
          Expanded(
            child: products.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border, size: 80, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text('Your wishlist is empty', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // Perkecil tinggi kartu agar konsisten dengan home
                      childAspectRatio: 0.80,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _buildProductCard(product, index);
                    },
                  ),
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 1,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }

  Widget _chip(String label) => LensChip(
        label: label,
        selected: selectedCategory == label,
        onTap: () => setState(() => selectedCategory = label),
      );

  Widget _buildProductCard(Product product, int index) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail produk
        Navigator.pushNamed(
          context,
          '/product-detail',
          arguments: {
            'id': product.id,
            'name': product.name,
            'price': product.price,
            'image': product.imageUrl,
            'rating': product.rating,
            'category': product.category,
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 2))],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Center(
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported, color: Colors.grey[400], size: 50),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, height: 1.3),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$${product.price}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14)),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.orange, size: 14),
                              const SizedBox(width: 4),
                              Text('${product.rating}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (product.isPowered)
              const Positioned(
                top: 12,
                left: 12,
                child: BadgePowered(),
              ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => _removeFromWishlist(index),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)]),
                  child: const Icon(Icons.close, color: Colors.red, size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget kecil untuk reusable
class BadgeCount extends StatelessWidget {
  final int count;
  const BadgeCount({Key? key, required this.count}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
      child: Text('$count', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
    );
  }
}

class BadgePowered extends StatelessWidget {
  const BadgePowered({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(6)),
      child: const Text('POWERED', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.blue, letterSpacing: 0.5)),
    );
  }
}