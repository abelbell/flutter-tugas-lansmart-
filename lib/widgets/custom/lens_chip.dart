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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFC870) : Colors.white,
          borderRadius: BorderRadius.circular(8), // Kotak dengan sudut sedikit melengkung
          border: Border.all(
            color: selected ? const Color(0xFFFFC870) : const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'TomatoGrotesk',
            color: Colors.black,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
