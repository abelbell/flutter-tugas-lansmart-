import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool isOngoingSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Order',
          style: TextStyle(
            fontFamily: 'TomatoGrotesk',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Tab Selector (Ongoing / Completed)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isOngoingSelected = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      decoration: BoxDecoration(
                        color: isOngoingSelected ? const Color(0xFFFFA500) : Colors.white,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Ongoing',
                        style: TextStyle(
                          fontFamily: 'TomatoGrotesk',
                          color: isOngoingSelected ? Colors.black : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isOngoingSelected = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      decoration: BoxDecoration(
                        color: !isOngoingSelected ? const Color(0xFFFFA500) : Colors.white,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Completed',
                        style: TextStyle(
                          fontFamily: 'TomatoGrotesk',
                          color: !isOngoingSelected ? Colors.black : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Order List
          Expanded(
            child: _buildOrderList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: GestureDetector(
            onTap: () {
              // Navigate to product detail
              Navigator.pushNamed(
                context,
                '/product-detail',
                arguments: {
                  'image': 'assets/images/product${(index % 6) + 1}.png',
                  'name': 'Silver Purple Full Rim Cat Eye',
                  'price': 1100,
                  'rating': 4.8,
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Product Image
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/images/product${(index % 6) + 1}.png',
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  
                  // Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Silver Purple Full Rim',
                          style: TextStyle(
                            fontFamily: 'TomatoGrotesk',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const Text(
                          'Cat Eye',
                          style: TextStyle(
                            fontFamily: 'TomatoGrotesk',
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Text(
                            'Track Order',
                            style: TextStyle(
                              fontFamily: 'TomatoGrotesk',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        const Text(
                          'FREE Delivery',
                          style: TextStyle(
                            fontFamily: 'TomatoGrotesk',
                            color: Colors.green,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Price and Rating
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          '\$1100',
                          style: TextStyle(
                            fontFamily: 'TomatoGrotesk',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: const [
                            Icon(
                              Icons.star,
                              color: Color(0xFFFFA500),
                              size: 16.0,
                            ),
                            Text(
                              '4.8',
                              style: TextStyle(
                                fontFamily: 'TomatoGrotesk',
                                fontSize: 14.0,
                              ),
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
        );
      },
    );
  }
}