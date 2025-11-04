// models/credit_card_model.dart
import 'package:flutter/material.dart';

class CreditCardModel {
  final String cardNumber;
  final String cardHolder;
  final String expiry;
  final String cvv;
  final bool isVisa;
  final Color backgroundColor;

  const CreditCardModel({
    required this.cardNumber,
    required this.cardHolder,
    required this.expiry,
    required this.cvv,
    required this.isVisa,
    this.backgroundColor = const Color(0xFFFFC870),
  });

  // Optional: untuk debugging atau copy
  CreditCardModel copyWith({
    String? cardNumber,
    String? cardHolder,
    String? expiry,
    String? cvv,
    bool? isVisa,
    Color? backgroundColor,
  }) {
    return CreditCardModel(
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolder: cardHolder ?? this.cardHolder,
      expiry: expiry ?? this.expiry,
      cvv: cvv ?? this.cvv,
      isVisa: isVisa ?? this.isVisa,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}