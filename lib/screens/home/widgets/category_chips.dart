// lib/screens/home/widgets/category_chips.dart
import 'package:flutter/material.dart';
import '../../../widgets/custom/lens_chip.dart';

class CategoryChips extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final ValueChanged<String> onSelected;

  const CategoryChips({
    Key? key,
    required this.categories,
    required this.selected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = cat == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: LensChip(
              label: cat,
              selected: isSelected,
              onTap: () => onSelected(cat),
            ),
          );
        },
      ),
    );
  }
}