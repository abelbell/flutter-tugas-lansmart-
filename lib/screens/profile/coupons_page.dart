// lib/models/coupons_page.dart
import 'package:flutter/material.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Coupons',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Horizontal Scrollable Coupons ===
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CouponCard(
                    discount: '25% Off',
                    subtitle: 'on first order',
                    color: Color(0xFF8B4513), // Brown
                  ),
                  SizedBox(width: 12),
                  CouponCard(
                    discount: '50% Off',
                    subtitle: 'on first order',
                    color: Color(0xFF654321), // Darker brown
                  ),
                  SizedBox(width: 12),
                  CouponCard(
                    discount: '15% Off',
                    subtitle: 'on first order',
                    color: Colors.green,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // === New Upcoming Section ===
            const Text(
              'New Upcoming',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            const UpcomingCouponItem(
              discount: '20% Off',
              title: 'Home Decor',
              minPurchase: 'On minimum purchase of Rs. 1,999',
            ),
            const SizedBox(height: 12),
            const UpcomingCouponItem(
              discount: '50% Off',
              title: 'Home Furnishing',
              minPurchase: 'On minimum purchase of Rs. 12,999',
            ),
            const SizedBox(height: 12),
            const UpcomingCouponItem(
              discount: '25% Off',
              title: 'Mobile Accessories',
              minPurchase: 'On minimum purchase of Rs. 999',
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// === Widget: Main Coupon Card (Horizontal) ===
class CouponCard extends StatelessWidget {
  final String discount;
  final String subtitle;
  final Color color;

  const CouponCard({
    Key? key,
    required this.discount,
    required this.subtitle,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            discount,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: color,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minimumSize: const Size(double.infinity, 36),
            ),
            child: const Text(
              'Redeem',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// === Widget: Upcoming Coupon Item ===
class UpcomingCouponItem extends StatelessWidget {
  final String discount;
  final String title;
  final String minPurchase;

  const UpcomingCouponItem({
    Key? key,
    required this.discount,
    required this.title,
    required this.minPurchase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              discount,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  minPurchase,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}