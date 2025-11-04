// lib/screens/product/product_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../../providers/keranjang_provider.dart';
import 'package:eyewear_shop/screens/profile/track_order_page.dart' hide ReviewsPage;

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedImageIndex = 0;
  int _quantity = 1;
  int _selectedColorIndex = 0;

  late final List<String> _productImages;

  final List<Color> _colors = [
    const Color(0xFFD4A574),
    const Color(0xFF2196F3),
    const Color(0xFF8B4513),
    const Color(0xFF757575),
    const Color(0xFF9C27B0),
    const Color(0xFF4CAF50),
    const Color(0xFF66BB6A),
  ];

  @override
  void initState() {
    super.initState();
    // Gunakan gambar yang dikirim lewat arguments jika tersedia,
    // fallback ke aset yang sudah ada di proyek.
    final argImage = widget.product['image'] as String?;
    final fallback1 = 'assets/images/product1.png';
    final fallback2 = 'assets/images/product5.png';
    final fallback3 = 'assets/images/product9.png';
    _productImages = [
      if (argImage != null && argImage.isNotEmpty) argImage else fallback1,
      fallback2,
      fallback3,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<KeranjangProvider>().jumlah;
    final originalPrice = widget.product['price'] as int;
    final discountedPrice = (originalPrice * 0.87).round();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(fontFamily: 'TomatoGrotesk', fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -8, end: -10),
              badgeContent: Text(
                cartCount.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              badgeStyle: const badges.BadgeStyle(badgeColor: Colors.red),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Image
            Container(
              height: 350,
              width: double.infinity,
              color: const Color(0xFFF8F8F8),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              alignment: Alignment.center,
              child: Image.asset(
                _productImages[_selectedImageIndex],
                fit: BoxFit.contain,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 80),
              ),
            ),

            const SizedBox(height: 12),

            // Thumbnails
            Container(
              height: 90,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _productImages.length,
                itemBuilder: (ctx, i) {
                  final isSelected = i == _selectedImageIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedImageIndex = i),
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8),
                        border: Border.all(
                          color: isSelected ? Colors.orange : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(_productImages[i], fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thivi Blouse',
                        style: TextStyle(
                          fontFamily: 'TomatoGrotesk',
                          color: Colors.red.shade700,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          const Text(
                            '4.5',
                            style: TextStyle(fontFamily: 'TomatoGrotesk', fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(470)',
                            style: TextStyle(fontFamily: 'TomatoGrotesk', fontSize: 14, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Product Name
                  Text(
                    widget.product['name'] as String,
                    style: const TextStyle(
                      fontFamily: 'TomatoGrotesk',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Price & Quantity Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\\$discountedPrice',
                            style: const TextStyle(
                              fontFamily: 'TomatoGrotesk',
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              height: 1,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              '\\$originalPrice',
                              style: TextStyle(
                                fontFamily: 'TomatoGrotesk',
                                fontSize: 18,
                                color: Colors.grey.shade500,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Quantity
                      Row(
                        children: [
                          _quantityButton(Icons.remove, () {
                            setState(() => _quantity = _quantity > 1 ? _quantity - 1 : 1);
                          }),
                          Container(
                            width: 50,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              color: Colors.white,
                            ),
                            child: Text(
                              _quantity.toString(),
                              style: const TextStyle(
                                fontFamily: 'TomatoGrotesk',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          _quantityButton(Icons.add, () {
                            setState(() => _quantity++);
                          }),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Colors
                  const Text(
                    'Items Color:',
                    style: TextStyle(
                      fontFamily: 'TomatoGrotesk',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: _colors.asMap().entries.map((e) {
                      int i = e.key;
                      Color color = e.value;
                      final isSelected = i == _selectedColorIndex;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedColorIndex = i),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? Colors.black : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? const Icon(Icons.check, color: Colors.white, size: 20)
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Description
                  const Text(
                    'Description:',
                    style: TextStyle(fontFamily: 'TomatoGrotesk', fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humor.',
                    style: TextStyle(
                      fontFamily: 'TomatoGrotesk',
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)]),
        child: ElevatedButton(
          onPressed: () {
            context.read<KeranjangProvider>().tambah();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart!')));
            Navigator.pushNamed(context, '/cart');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFDD096),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            minimumSize: const Size.fromHeight(52),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart, color: Colors.black),
              SizedBox(width: 8),
              Text('Add To Cart', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }
}
