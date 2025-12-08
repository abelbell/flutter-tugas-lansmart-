import 'package:flutter/material.dart';

class SavedCardsPage extends StatefulWidget {
  SavedCardsPage({Key? key}) : super(key: key);

  @override
  State<SavedCardsPage> createState() => _SavedCardsPageState();
}

class _SavedCardsPageState extends State<SavedCardsPage> {
  int selectedCard = 0;
  int selectedMethod = 1;

  final List<Map<String, dynamic>> cards = [
    {
      "type": "CREDIT CARD",
      "brand": "VISA",
      "number": "**** **** **** 4532",
      "exp": "14/07",
      "cvv": "012",
      "name": "ROOPA SMITH",
      "color": const Color(0xFFFFCC80),
      "textColor": Colors.black,
    },
    {
      "type": "DEBIT CARD",
      "brand": "MasterCard",
      "number": "**** **** **** 8973",
      "exp": "08/26",
      "cvv": "453",
      "name": "ROOPA SMITH",
      "color": const Color(0xFF4E4E4E),
      "textColor": Colors.white,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          "Payment",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Add Card clicked")),
                );
              },
              icon: const Icon(
                Icons.add_circle_outline,
                color: Color(0xFFFFA726),
                size: 18,
              ),
              label: const Text(
                "Add Card",
                style: TextStyle(
                  color: Color(0xFFFFA726),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Credit / Debit Cards",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // === List kartu horizontal ===
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];
                  final isSelected = index == selectedCard;

                  return GestureDetector(
                    onTap: () => setState(() => selectedCard = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 16),
                      width: 280,
                      decoration: BoxDecoration(
                        color: card["color"] as Color,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFFFB74D)
                              : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 6,
                            spreadRadius: 1,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Bar atas
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    isSelected
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off,
                                    color: card["textColor"] as Color,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    card["type"] as String,
                                    style: TextStyle(
                                      color: card["textColor"] as Color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                card["brand"] as String,
                                style: TextStyle(
                                  color: card["textColor"] as Color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            card["number"] as String,
                            style: TextStyle(
                              color: card["textColor"] as Color,
                              fontSize: 20,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "EXP ${card["exp"]}",
                                style: TextStyle(
                                  color: (card["textColor"] as Color)
                                      .withOpacity(0.9),
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "CVV ${card["cvv"]}",
                                style: TextStyle(
                                  color: (card["textColor"] as Color)
                                      .withOpacity(0.9),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            card["name"] as String,
                            style: TextStyle(
                              color: card["textColor"] as Color,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // === Payment methods ===
            _buildPaymentOption(
              icon: Icons.attach_money,
              title: "Cash on Delivery (Cash/UPI)",
              index: 0,
            ),
            const SizedBox(height: 10),
            _buildPaymentOption(
              icon: Icons.account_balance_wallet_outlined,
              title: "Google Pay / PhonePe / BHIM UPI",
              index: 1,
              hasInputField: true,
            ),
            const SizedBox(height: 10),
            _buildPaymentOption(
              icon: Icons.folder_open,
              title: "Payments / Wallet",
              index: 2,
            ),
            const SizedBox(height: 10),
            _buildPaymentOption(
              icon: Icons.account_balance,
              title: "Netbanking",
              index: 3,
            ),
            const SizedBox(height: 30),

            // === Tombol continue ===
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Continue pressed")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB74D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // === Widget opsi pembayaran ===
  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required int index,
    bool hasInputField = false,
  }) {
    final isSelected = index == selectedMethod;

    return GestureDetector(
      onTap: () => setState(() => selectedMethod = index),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFFFFA726)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: const Color(0xFFFFA726),
                ),
              ],
            ),
            if (hasInputField && isSelected) ...[
              const SizedBox(height: 14),
              const Text(
                "Link Via UPI*",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.black87),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your UPI ID",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFB74D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.verified_user, color: Color(0xFFFFB74D), size: 18),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "Your UPI ID will be encrypted and is 100% safe with us.",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}