// lib/screens/reviews/reviews_page.dart
import 'package:flutter/material.dart';
import '../product/product_detail_screen.dart';

class ReviewsPage extends StatefulWidget {
  final Map<String, dynamic>? product;

  const ReviewsPage({Key? key, this.product}) : super(key: key);

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  final List<Map<String, dynamic>> _myReviews = [];

  int _currentRating = 0;
  final _titleController = TextEditingController();
  final _reviewController = TextEditingController();
  bool _recommend = true;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _titleController.text = 'Review for ${widget.product!['name']}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Write Review',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === GAMBAR PRODUK BESAR + KLIKABLE ===
            if (widget.product != null) ...[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(product: widget.product!),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: [
                      // Gambar Besar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          widget.product!['image'] ?? 'assets/images/glasses.png',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Info Produk
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              widget.product!['image'] ?? 'assets/images/glasses.png',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.product!['name'],
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                                ),
                                const Text(
                                  'FREE Delivery',
                                  style: TextStyle(color: Colors.green, fontSize: 12),
                                ),
                                Text(
                                  '\$${widget.product!['price']}',
                                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          const Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                              Text('4.8', style: TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // === FORM REVIEW ===
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Overall Rating',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your Average Rating is 4.0',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (i) {
                      return GestureDetector(
                        onTap: () => setState(() => _currentRating = i + 1),
                        child: Icon(
                          i < _currentRating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 36,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),

                  const Text('Review Title', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Give your review a title',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text('Product Review', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _reviewController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Write your experience...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text('Would you recommend this product to a friend?', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _radio('Yes', true),
                      const SizedBox(width: 32),
                      _radio('No', false),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // === MY REVIEWS LIST ===
            const Text('My Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _myReviews.isEmpty
                ? const Center(
              child: Text(
                'You haven’t written any reviews yet',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            )
                : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _myReviews.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final review = _myReviews[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(product: review['product']),
                      ),
                    );
                  },
                  child: _buildReviewCard(review),
                );
              },
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      // === SUBMIT BUTTON ===
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: SizedBox(
          height: 52,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _submitReview,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFDD096),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            ),
            child: const Text(
              'Submit Review',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _radio(String label, bool value) {
    return GestureDetector(
      onTap: () => setState(() => _recommend = value),
      child: Row(
        children: [
          Radio<bool>(
            value: value,
            groupValue: _recommend,
            onChanged: (v) => setState(() => _recommend = v!),
            activeColor: Colors.black,
          ),
          Text(label, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  review['product']['image'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['product']['name'],
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    Text(
                      review['date'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (i) {
                  return Icon(
                    i < review['rating'] ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 16,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(review['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(review['review'], style: TextStyle(color: Colors.grey[700], height: 1.5)),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.thumb_up, size: 16, color: review['recommend'] ? Colors.green : Colors.grey),
              const SizedBox(width: 4),
              Text(
                review['recommend'] ? 'Recommended' : 'Not Recommended',
                style: TextStyle(color: review['recommend'] ? Colors.green : Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submitReview() {
    if (_currentRating == 0 || _titleController.text.isEmpty || _reviewController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields')),
      );
      return;
    }

    setState(() {
      final product = widget.product ?? {
        'name': 'Silver Purple Full Rim Cat Eye',
        'price': 100,
        'image': 'assets/images/glasses.png',
      };
      _myReviews.insert(0, {
        'product': product,
        'rating': _currentRating,
        'title': _titleController.text,
        'review': _reviewController.text,
        'recommend': _recommend,
        'date': 'Nov 04, 2025',
      });
    });

    _currentRating = 0;
    _titleController.clear();
    _reviewController.clear();
    _recommend = true;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Review submitted!')),
    );
  }
}