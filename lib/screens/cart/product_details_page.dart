// lib/screens/cart/product_details_page.dart
import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'delivery_address_page.dart';
import 'cart_page.dart';

// HAPUS INI:
// import '../widgets/badge_count.dart';

// PINDAHKAN BadgeCount KE SINI
class BadgeCount extends StatelessWidget {
  final int count;
  const BadgeCount({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
      child: Text('$count', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
    );
  }
}

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);
  @override State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedColorIndex = 0;
  int quantity = 1;
  final List<Color> colors = [Colors.blue, Colors.black, Colors.purple];

  final List<String> imageList = [
    'assets/images/product9.png',
    'assets/images/product5.png',
    'assets/images/product1.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
        title: const Text('Product Details', style: TextStyle(color: Colors.black, fontSize: 18)),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined,
                    color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ),
                  );
                },
              ),
              const Positioned(right: 8, top: 8, child: BadgeCount(count: 14)), // const OK
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🟠 Gambar Produk (Carousel)
                  Container(
                    height: 300,
                    color: Colors.grey[50],
                    child: Center(
                      child: Image.asset(
                        widget.product.imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported, size: 100),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 🟢 Pilihan Warna (Emoji)
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: colors.length,
                      itemBuilder: (context, index) {
                        final isSelected = selectedColorIndex == index;
                        return GestureDetector(
                          onTap: () => setState(() => selectedColorIndex = index),
                          child: Container(
                            width: 80,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: colors[index],
                              border: Border.all(color: isSelected ? const Color(0xFFFFC870) : Colors.grey[300]!, width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 🔵 Detail Produk
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Judul & Rating
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.product.category, style: const TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w500)),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.orange, size: 20),
                                const SizedBox(width: 4),
                                Text('${widget.product.rating} (470)', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Nama Produk
                        Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'TomatoGrotesk',
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Harga & Quantity
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Price:', style: TextStyle(fontSize: 16, color: Colors.grey)),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text('\$${widget.product.price}', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.red[700])),
                                      const SizedBox(width: 8),
                                      const Text(
                                        '\$310',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                          decoration:
                                          TextDecoration.lineThrough,
                                          fontFamily: 'TomatoGrotesk',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Quantity Picker
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Quantity:', style: TextStyle(fontSize: 16, color: Colors.grey)),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    IconButton(onPressed: () => setState(() => quantity = quantity > 1 ? quantity - 1 : 1), icon: const Icon(Icons.remove), style: IconButton.styleFrom(backgroundColor: Colors.grey[200])),
                                    Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text('$quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                                    IconButton(onPressed: () => setState(() => quantity++), icon: const Icon(Icons.add), style: IconButton.styleFrom(backgroundColor: Colors.grey[200])),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🛒 Tombol Add to Cart
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DeliveryAddressPage())),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFC870), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.shopping_cart_outlined, color: Colors.black), SizedBox(width: 12), Text('Add To Cart', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black))]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}