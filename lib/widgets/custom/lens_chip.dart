// lib/widgets/custom/lens_chip.dart
import 'package:flutter/material.dart';

class LensChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const LensChip({
    Key? key,
    required this.label,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
    alignment: Alignment.center,

  constraints: const BoxConstraints(minWidth: 96, minHeight: 14),
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        decoration: BoxDecoration(
       
          color: selected ? const Color(0xFFFFD794) : Colors.white,

          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? const Color(0xFFFFD794) : const Color(0xFFECECEC),
            width: 1,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'TomatoGrotesk',
            color: Colors.black,
            fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
