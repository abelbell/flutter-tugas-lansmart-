// lib/screens/home/widgets/filter_content.dart
import 'package:flutter/material.dart';

class FilterContent extends StatefulWidget {
  const FilterContent({Key? key}) : super(key: key);

  @override
  State<FilterContent> createState() => _FilterContentState();
}

class _FilterContentState extends State<FilterContent> {
  List<String> selectedBrands = ['Adidas'];
  List<String> selectedCategories = ['All'];
  List<String> selectedSizes = ['Small'];
  RangeValues priceRange = const RangeValues(50, 270);

  final List<String> brands = ['Adidas', 'Reebok', 'Zara', 'Gucci', 'Vogue'];
  final List<String> categoriesList = ['All', 'Child', 'Men', 'Women', 'Dress', 'Jackets', 'Jeans'];
  final List<String> sizes = ['Small', 'Medium', 'Large', 'XL', '2XL'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filters',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Brands'),
              TextButton(
                onPressed: () {},
                child: const Text('See All', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: brands.map((brand) {
              final isSelected = selectedBrands.contains(brand);
              return ChoiceChip(
                label: Text(brand),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedBrands.add(brand);
                    } else {
                      selectedBrands.remove(brand);
                    }
                  });
                },
                backgroundColor: Colors.grey[200],
                selectedColor: const Color(0xFFFFA726),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Categories:'),
              TextButton(
                onPressed: () {},
                child: const Text('See All', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categoriesList.map((cat) {
              final isSelected = selectedCategories.contains(cat);
              return ChoiceChip(
                label: Text(cat),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedCategories.add(cat);
                    } else {
                      selectedCategories.remove(cat);
                    }
                  });
                },
                backgroundColor: Colors.grey[200],
                selectedColor: const Color(0xFFFFA726),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Size:'),
              TextButton(
                onPressed: () {},
                child: const Text('See All', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: sizes.map((size) {
              final isSelected = selectedSizes.contains(size);
              return ChoiceChip(
                label: Text(size),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedSizes.add(size);
                    } else {
                      selectedSizes.remove(size);
                    }
                  });
                },
                backgroundColor: Colors.grey[200],
                selectedColor: const Color(0xFFFFA726),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text('Price:'),
          RangeSlider(
            values: priceRange,
            min: 50,
            max: 270,
            divisions: 220,
            activeColor: Colors.red,
            inactiveColor: Colors.grey,
            labels: RangeLabels(
              '${priceRange.start.round()}',
              '${priceRange.end.round()}',
            ),
            onChanged: (RangeValues values) {
              setState(() {
                priceRange = values;
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedBrands = ['Adidas'];
                      selectedCategories = ['All'];
                      selectedSizes = ['Small'];
                      priceRange = const RangeValues(50, 270);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: const Text('Reset'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Apply filters here (update search or grid if implemented)
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFA726),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}