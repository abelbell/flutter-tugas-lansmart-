// widgets/credit_card_widget.dart
import 'package:flutter/material.dart';
import '../../../models/credit_card_model.dart';

class CreditCardWidget extends StatelessWidget {
  final CreditCardModel card;
  final bool isSelected;
  final VoidCallback onTap;

  const CreditCardWidget({
    Key? key,
    required this.card,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = card.backgroundColor == const Color(0xFFFFC870);
    final textColor = isLight ? Colors.black : Colors.white;
    final secondaryTextColor = isLight ? Colors.black54 : Colors.white70;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: card.backgroundColor,
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
            // Header: CREDIT CARD + VISA
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
                          color: isLight ? Colors.black : Colors.white,
                          width: 2,
                        ),
                        color: isSelected
                            ? (isLight ? Colors.black : Colors.white)
                            : Colors.transparent,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'CREDIT CARD',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                if (card.isVisa)
                  Text(
                    'VISA',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: textColor,
                    ),
                  ),
              ],
            ),

            // Card Number
            Text(
              card.cardNumber,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
                color: textColor,
              ),
            ),

            // Footer: Holder, EXP, CVV
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  card.cardHolder,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                _buildInfoColumn('EXP', card.expiry, textColor, secondaryTextColor),
                _buildInfoColumn('CVV', card.cvv, textColor, secondaryTextColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value, Color textColor, Color secondaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10, color: secondaryColor),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }
}