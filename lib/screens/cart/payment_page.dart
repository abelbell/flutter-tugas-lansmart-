// lib/screens/cart/payment_page.dart
import 'package:flutter/material.dart';
import 'widgets/credit_card_widget.dart'; // BENAR: dari folder yang sama
import '../../models/credit_card_model.dart'; // Import model

// ====== CREDIT CARD WIDGET ======
class CreditCardWidget extends StatelessWidget {
  final String cardNumber;
  final String cardHolder;
  final String expiry;
  final String cvv;
  final bool isVisa;
  final bool isSelected;
  final VoidCallback onTap;
  final Color backgroundColor;

  const CreditCardWidget({
    Key? key,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiry,
    required this.cvv,
    required this.isVisa,
    required this.isSelected,
    required this.onTap,
    this.backgroundColor = const Color(0xFFFFA726),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: backgroundColor == const Color(0xFFFFA726)
                              ? Colors.black
                              : Colors.white,
                          width: 2,
                        ),
                        color: isSelected
                            ? (backgroundColor == const Color(0xFFFFA726)
                                ? Colors.black
                                : Colors.white)
                            : Colors.transparent,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'CREDIT CARD',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: backgroundColor == const Color(0xFFFFA726)
                            ? Colors.black
                            : Colors.white,
                        fontFamily: 'TomatoGrotesk',
                      ),
                    ),
                  ],
                ),
                if (isVisa)
                  Text(
                    'VISA',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: backgroundColor == const Color(0xFFFFA726)
                          ? Colors.black
                          : Colors.white,
                      fontFamily: 'TomatoGrotesk',
                    ),
                  ),
              ],
            ),
            Text(
              cardNumber,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
                color: backgroundColor == const Color(0xFFFFA726)
                    ? Colors.black
                    : Colors.white,
                fontFamily: 'TomatoGrotesk',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cardHolder,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: backgroundColor == const Color(0xFFFFA726)
                        ? Colors.black
                        : Colors.white,
                    fontFamily: 'TomatoGrotesk',
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'EXP',
                      style: TextStyle(
                        fontSize: 10,
                        color: backgroundColor == const Color(0xFFFFA726)
                            ? Colors.black54
                            : Colors.white70,
                        fontFamily: 'TomatoGrotesk',
                      ),
                    ),
                    Text(
                      expiry,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: backgroundColor == const Color(0xFFFFA726)
                            ? Colors.black
                            : Colors.white,
                        fontFamily: 'TomatoGrotesk',
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'CVV',
                      style: TextStyle(
                        fontSize: 10,
                        color: backgroundColor == const Color(0xFFFFA726)
                            ? Colors.black54
                            : Colors.white70,
                        fontFamily: 'TomatoGrotesk',
                      ),
                    ),
                    Text(
                      cvv,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: backgroundColor == const Color(0xFFFFA726)
                            ? Colors.black
                            : Colors.white,
                        fontFamily: 'TomatoGrotesk',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = 'upi';
  final TextEditingController upiController = TextEditingController();

  // Daftar kartu kredit menggunakan CreditCardModel
  final List<CreditCardModel> cards = [
    CreditCardModel(
      cardNumber: '**** **** **** 4532',
      cardHolder: 'ROOPA SMITH',
      expiry: '14/07',
      cvv: '012',
      isVisa: true,
    ),
    CreditCardModel(
      cardNumber: '**** **** **** 8976',
      cardHolder: 'ROOPA SMITH',
      expiry: '10/25',
      cvv: '345',
      isVisa: false,
      backgroundColor: Colors.grey[800]!,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Payment Method',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'TomatoGrotesk',
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Credit/Debit Card',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'TomatoGrotesk',
                          ),
                        ),
                        Text(
                          'Add Card',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFFFA726),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'TomatoGrotesk',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        CreditCardWidget(
                          cardNumber: '**** **** **** 4532',
                          cardHolder: 'ROOPA SMITH',
                          expiry: '14/07',
                          cvv: '012',
                          isVisa: true,
                          isSelected: selectedPaymentMethod == 'card1',
                          onTap: () {
                            setState(() {
                              selectedPaymentMethod = 'card1';
                            });
                          },
                        ),
                        const SizedBox(width: 12),
                        CreditCardWidget(
                          cardNumber: '**** **** **** 8976',
                          cardHolder: 'ROOPA SMITH',
                          expiry: '10/25',
                          cvv: '345',
                          isVisa: false,
                          isSelected: selectedPaymentMethod == 'card2',
                          onTap: () {
                            setState(() {
                              selectedPaymentMethod = 'card2';
                            });
                          },
                          backgroundColor: const Color(0xFF424242),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: RadioListTile<String>(
                        value: 'cod',
                        groupValue: selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentMethod = value!;
                          });
                        },
                        activeColor: const Color(0xFFFFA726),
                        title: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFA726).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.attach_money,
                                color: Color(0xFFFFA726),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Cash on Delivery(Cash/UPI)',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'TomatoGrotesk',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedPaymentMethod == 'upi'
                              ? const Color(0xFFFFA726)
                              : const Color(0xFFE0E0E0),
                          width: selectedPaymentMethod == 'upi' ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            value: 'upi',
                            groupValue: selectedPaymentMethod,
                            onChanged: (value) {
                              setState(() {
                                selectedPaymentMethod = value!;
                              });
                            },
                            activeColor: const Color(0xFFFFA726),
                            title: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFA726)
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.account_balance_wallet_outlined,
                                    color: Color(0xFFFFA726),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Text(
                                    'Google Pay/Phone Pay/BHIM UPI',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'TomatoGrotesk',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (selectedPaymentMethod == 'upi')
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Link Via UPI*',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'TomatoGrotesk',
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: upiController,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter your UPI ID',
                                      hintStyle: TextStyle(
                                        color: Color(0xFFBDBDBD),
                                        fontFamily: 'TomatoGrotesk',
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: Color(0xFFE0E0E0)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: Color(0xFFE0E0E0)),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFFFA726),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                      ),
                                      child: const Text(
                                        'Continue',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontFamily: 'TomatoGrotesk',
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFA726)
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: const Icon(
                                          Icons.check_circle_outline,
                                          color: Color(0xFFFFA726),
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Expanded(
                                        child: Text(
                                          'Your UPI ID Will be encrypted and is 100% safe with us.',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF757575),
                                            fontFamily: 'TomatoGrotesk',
                                          ),
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
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFA726),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'TomatoGrotesk',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    upiController.dispose();
    super.dispose();
  }
}