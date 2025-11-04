// lib/screens/profile/track_order_page.dart
import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../cart/product_details_page.dart';

class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    // PERBAIKAN: Sesuaikan dengan Product model
    final Product product = Product(
      id: '1',
      name: 'Silver Purple Full Rim',       // Ganti title → name
      price: 1100,                          // int, bukan double
      imageUrl: 'assets/images/product2.png', // Ganti image → imageUrl
      rating: 4.8,
      isPowered: false,
      category: 'Cat Eye',                  // OK
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Track Order',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontFamily: 'TomatoGrotesk',
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kartu produk
            GestureDetector(
              onTap: () {
                // Navigasi ke halaman detail produk menggunakan route
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
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar produk - Clickable dengan visual feedback
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[100],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          product.imageUrl, // Ganti product.image → product.imageUrl
                          width: 100,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported, size: 50),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Info produk
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name, // Ganti product.title → product.name
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'TomatoGrotesk',
                            ),
                          ),
                          Text(
                            product.category, // OK
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontFamily: 'TomatoGrotesk',
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'FREE Delivery',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 13,
                              fontFamily: 'TomatoGrotesk',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${product.price}', // int → langsung tampil
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'TomatoGrotesk',
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Rating
                    Column(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        Text(
                          product.rating.toString(), // OK
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Track order',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'TomatoGrotesk',
              ),
            ),
            const SizedBox(height: 16),

            // Timeline status pesanan
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _OrderStep(
                  title: 'Order Placed',
                  date: '27 Dec 2023',
                  description: 'We have received your order',
                  isDone: true,
                ),
                _OrderStep(
                  title: 'Order Confirmed',
                  date: '27 Dec 2023',
                  description: 'We have confirmed your order',
                  isDone: true,
                ),
                _OrderStep(
                  title: 'Order Processed',
                  date: '28 Dec 2023',
                  description: 'We are preparing your order',
                  isDone: false,
                ),
                _OrderStep(
                  title: 'Ready To Ship',
                  date: '29 Dec 2023',
                  description: 'Your order is ready for shipping',
                  isDone: false,
                ),
                _OrderStep(
                  title: 'Out For Delivery',
                  date: '31 Dec 2023',
                  description: 'Your order is out for delivery',
                  isDone: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget langkah-langkah order
class _OrderStep extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final bool isDone;

  const _OrderStep({
    required this.title,
    required this.date,
    required this.description,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    const Color activeColor = Color(0xFFFF9800); // Warna oranye
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Kiri: ikon dan garis
        Column(
          children: [
            Icon(
              isDone ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isDone ? activeColor : Colors.grey.shade400,
              size: 22,
            ),
            Container(
              width: 2,
              height: 35,
              color: Colors.grey.shade300,
            ),
          ],
        ),
        const SizedBox(width: 12),

        // Kanan: teks
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: title,
                    style: TextStyle(
                      color: isDone ? activeColor : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'TomatoGrotesk',
                    ),
                    children: [
                      TextSpan(
                        text: '   $date',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          fontFamily: 'TomatoGrotesk',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'TomatoGrotesk',
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}