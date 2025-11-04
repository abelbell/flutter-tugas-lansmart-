import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../../widgets/custom/lens_chip.dart';
import '../../providers/keranjang_provider.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  final String title;
  const ProductListScreen({super.key, required this.title});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = [
    'Crazy Deals',
    'Budget Buys',
    'Best Offer',
    'Women',
    'Dress',
    'Unisex',
  ];
  bool _isListView = false; // Toggle untuk grid/list view
  final Set<int> _liked = <int>{};
  
  // State untuk modal
  String _selectedGender = 'Male';
  String _selectedSort = 'Necklace';
  List<String> _selectedBrands = <String>['Adidas'];
  List<String> _selectedCategories = <String>['All'];
  List<String> _selectedSizes = <String>['Small'];

  final List<Map<String, dynamic>> products = List.generate(20, (i) {
    final imageIndex = (i % 6) + 1;
    return {
      'image': 'assets/images/product$imageIndex.png',
      'name': 'Silver Purple Full Rim Cat Eye',
      'price': 1100,
      'rating': 4.8,
      'powered': [2, 3, 5, 7, 9, 11, 13, 15].contains(i),
    };
  });

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<KeranjangProvider>().jumlah;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8), // Kotak dengan sudut sedikit melengkung
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search Products',
              hintStyle: const TextStyle(
                fontFamily: 'TomatoGrotesk',
                fontSize: 14,
                color: Colors.grey,
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0), // Vertical 0 untuk center
              isDense: true, // Membuat input lebih compact
            ),
            style: const TextStyle(
              fontFamily: 'TomatoGrotesk',
              fontSize: 14,
            ),
            textAlignVertical: TextAlignVertical.center, // Align vertical center
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isListView ? Icons.grid_view : Icons.view_list,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isListView = !_isListView;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: 0, end: 0),
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.red,
                padding: EdgeInsets.all(5),
              ),
              badgeContent: Text(
                cartCount.toString(),
                style: const TextStyle(
                  fontFamily: 'TomatoGrotesk',
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips (horizontal)
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
            ),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, i) {
                final isSelected = i == _selectedFilter;
                return LensChip(
                  label: _filters[i],
                  selected: isSelected,
                  onTap: () => setState(() => _selectedFilter = i),
                );
              },
            ),
          ),
          // Product Grid or List
          Expanded(
            child: _isListView ? _buildList() : _buildGrid(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 65), // Kurangi bottom padding
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.68, // Card lebih panjang ke bawah untuk menampung semua konten
      ),
      itemCount: products.length,
      itemBuilder: (ctx, i) => _buildCard(products[i], i),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: products.length,
      itemBuilder: (ctx, i) {
        final p = products[i];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(product: p),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFEAEAEA)),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1)),
              ],
            ),
            child: Row(
              children: [
                // Image with Add To Cart button
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Container(
                    width: 120,
                    color: const Color(0xFFF8F8F8),
                    child: Column(
                      children: [
                        // Image area
                        Container(
                          height: 120,
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Image.asset(
                                  p['image'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                left: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _liked.contains(i) ? _liked.remove(i) : _liked.add(i);
                                    });
                                  },
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      _liked.contains(i) ? Icons.favorite : Icons.favorite_border,
                                      size: 14,
                                      color: _liked.contains(i) ? Colors.red : Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Add To Cart button
                        Padding(
                          padding: const EdgeInsets.fromLTRB(6, 0, 6, 8),
                          child: Container(
                            width: double.infinity,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text(
                                'Add To Cart',
                                style: TextStyle(
                                  fontFamily: 'TomatoGrotesk',
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          p['name'],
                          style: const TextStyle(
                            fontFamily: 'TomatoGrotesk',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'FREE Delivery',
                          style: TextStyle(
                            fontFamily: 'TomatoGrotesk',
                            fontSize: 12,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '\$${(p['price']).toString()}',
                          style: const TextStyle(
                            fontFamily: 'TomatoGrotesk',
                            color: Color(0xFFFF1144),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 14, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              p['rating'].toStringAsFixed(1),
                              style: const TextStyle(fontFamily: 'TomatoGrotesk', fontSize: 12, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: _buildBottomNavItem(Icons.person_outline, 'GENDER'),
          ),
          Container(
            width: 1,
            height: 30, // Tambahkan tinggi divider
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: _buildBottomNavItem(Icons.arrow_upward, 'SORT'),
          ),
          Container(
            width: 1,
            height: 30, // Tambahkan tinggi divider
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: _buildBottomNavItem(Icons.filter_list, 'FILTER'),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label) {
    return InkWell(
      onTap: () {
        if (label == 'GENDER') {
          _showGenderModal();
        } else if (label == 'SORT') {
          _showSortModal();
        } else if (label == 'FILTER') {
          _showFilterModal();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22, color: Colors.black87), // Kurangi dari 24 ke 22
          const SizedBox(height: 3), // Kurangi dari 4 ke 3
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'TomatoGrotesk', 
              fontSize: 11, // Kurangi dari 12 ke 11
              fontWeight: FontWeight.w600, 
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _showGenderModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54.withOpacity(0.5),
      builder: (context) {
        final bottomNavHeight = 60.0;
        return Container(
          margin: EdgeInsets.only(bottom: bottomNavHeight),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Gender',
                      style: TextStyle(fontFamily: 'TomatoGrotesk', fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildModalButton(
                        'Male',
                        _selectedGender == 'Male',
                        useBlackTextWhenSelected: true,
                        onTap: () {
                          setState(() => _selectedGender = 'Male');
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildModalButton(
                        'Female',
                        _selectedGender == 'Female',
                        useBlackTextWhenSelected: true,
                        onTap: () {
                          setState(() => _selectedGender = 'Female');
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSortModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54.withOpacity(0.5),
      builder: (context) {
        final bottomNavHeight = 60.0;
        return Container(
          margin: EdgeInsets.only(bottom: bottomNavHeight),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'SORT BY',
                      style: TextStyle(fontFamily: 'TomatoGrotesk', fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildModalButton(
                        'Necklace',
                        _selectedSort == 'Necklace',
                        useBlackTextWhenSelected: true,
                        onTap: () {
                          setState(() => _selectedSort = 'Necklace');
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildModalButton(
                        'Earrings',
                        _selectedSort == 'Earrings',
                        useBlackTextWhenSelected: true,
                        onTap: () {
                          setState(() => _selectedSort = 'Earrings');
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFilterModal() {
    final List<String> brands = ['Adidas', 'Reebok', 'Zara', 'Gucci', 'Vogue'];
    final List<String> categories = ['All', 'Child', 'Men', 'Women', 'Dress', 'Jackets', 'Jeans'];
    final List<String> sizes = ['Small', 'Medium', 'Large', 'XL', '2XL'];

    // Ensure lists are initialized - create new lists if needed
    if (_selectedBrands.isEmpty) {
      _selectedBrands = <String>['Adidas'];
    }
    if (_selectedCategories.isEmpty) {
      _selectedCategories = <String>['All'];
    }
    if (_selectedSizes.isEmpty) {
      _selectedSizes = <String>['Small'];
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54.withOpacity(0.5),
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          final bottomNavHeight = 60.0;
          final screenHeight = MediaQuery.of(context).size.height;
          final availableHeight = screenHeight - bottomNavHeight - MediaQuery.of(context).padding.bottom;
          
          return Container(
            margin: EdgeInsets.only(bottom: bottomNavHeight),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            constraints: BoxConstraints(
              maxHeight: availableHeight * 0.9,
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filters',
                        style: TextStyle(fontFamily: 'TomatoGrotesk', fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Brands Section
                          _buildFilterSection(
                            'Brands',
                            brands,
                            _selectedBrands,
                            (value) {
                              setModalState(() {
                                if (_selectedBrands.contains(value)) {
                                  _selectedBrands.remove(value);
                                } else {
                                  _selectedBrands.add(value);
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          // Categories Section
                          _buildFilterSection(
                            'Categories',
                            categories,
                            _selectedCategories,
                            (value) {
                              setModalState(() {
                                if (_selectedCategories.contains(value)) {
                                  _selectedCategories.remove(value);
                                } else {
                                  _selectedCategories.add(value);
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          // Size Section
                          _buildFilterSection(
                            'Size',
                            sizes,
                            _selectedSizes,
                            (value) {
                              setModalState(() {
                                if (_selectedSizes.contains(value)) {
                                  _selectedSizes.remove(value);
                                } else {
                                  _selectedSizes.add(value);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setModalState(() {
                              _selectedBrands = <String>[];
                              _selectedCategories = <String>[];
                              _selectedSizes = <String>[];
                            });
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: const Text(
                            'Reset',
                style: TextStyle(
                  fontFamily: 'TomatoGrotesk',
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFA500),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: const Text(
                            'Apply',
                style: TextStyle(
                  fontFamily: 'TomatoGrotesk',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
        },
      ),
    );
  }

  Widget _buildModalButton(String text, bool isSelected, {required VoidCallback onTap, bool useBlackTextWhenSelected = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFA500) : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? const Color(0xFFFFA500) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'TomatoGrotesk',
            color: isSelected
                ? (useBlackTextWhenSelected ? Colors.black : Colors.white)
                : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    List<String> options,
    List<String> selected,
    Function(String) onTap,
  ) {
    // `selected` is already a non-null List<String> (null-safety), so no need
    // to check for null or type. Use it directly.
    final List<String> safeSelected = selected;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontFamily: 'TomatoGrotesk', fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'See All',
                style: TextStyle(
                  fontFamily: 'TomatoGrotesk',
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.map((option) {
            final isSelected = safeSelected.contains(option);
            return GestureDetector(
              onTap: () => onTap(option),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFFA500) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? const Color(0xFFFFA500) : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    fontFamily: 'TomatoGrotesk',
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCard(Map<String, dynamic> p, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: p),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image area with white background
            Stack(
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(
                        p['image'],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                if (p['powered'] == true)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'POWERED',
                        style: TextStyle(
                          fontFamily: 'TomatoGrotesk',
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _liked.contains(index) ? _liked.remove(index) : _liked.add(index);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _liked.contains(index) ? Icons.favorite : Icons.favorite_border,
                        size: 18,
                        color: _liked.contains(index) ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Details
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    p['name'],
                    style: const TextStyle(
                      fontFamily: 'TomatoGrotesk',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${p['price']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Color(0xFFFFA726)),
                          const SizedBox(width: 4),
                          Text(
                            p['rating'].toStringAsFixed(1),
                            style: const TextStyle(
                              fontFamily: 'TomatoGrotesk',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}