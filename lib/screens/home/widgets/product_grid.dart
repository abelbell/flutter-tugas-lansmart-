// lib/screens/home/widgets/product_grid.dart
import 'package:flutter/material.dart';

import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  final List<String> productImages = const [
    'assets/images/product1.png',
    'assets/images/product2.png',
    'assets/images/product3.png',
    'assets/images/product4.png',
    'assets/images/product5.png',
    'assets/images/product6.png',
    'assets/images/product7.png',
    'assets/images/product8.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          // Perkecil tinggi kartu agar tampilan konsisten dan lebih ringkas
          childAspectRatio: 0.70,
        ),
        itemCount: productImages.length,
        itemBuilder: (context, index) {
          return ProductCard(image: productImages[index]);
        },
      ),
    );
  }
}