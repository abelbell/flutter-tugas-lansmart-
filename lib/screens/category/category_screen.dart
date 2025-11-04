import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/keranjang_provider.dart';
import '../product/product_list_screen.dart';
import '../../widgets/custom/custom_bottom_nav.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final List<Map<String, String>> mainCategories = [
      {'image': 'assets/images/category/category1.png', 'title': 'Child'},
      {'image': 'assets/images/category/category2.png', 'title': 'Men'},
      {'image': 'assets/images/category/category3.png', 'title': 'Women'},
    ];

    final List<Map<String, String>> subCategories = [
      {'image': 'assets/images/products1/products1.png', 'tag': 'Eyeglasses'},
      {'image': 'assets/images/products1/products2.png', 'tag': 'Sunglasses'},
      {'image': 'assets/images/products1/products3.png', 'tag': 'Screen Glasses'},
      {'image': 'assets/images/products1/products4.png', 'tag': 'Contact Lenses'},
      {'image': 'assets/images/products1/products5.png', 'tag': 'Power Sunglasses'},
      {'image': 'assets/images/products1/products6.png', 'tag': 'Progressive Lenses'},
    ];

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Category',
          style: TextStyle(
            fontFamily: 'TomatoGrotesk',
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: isDark ? Colors.grey[800] : const Color(0xFFECECEC),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set your wardrobe with our amazing selection!',
              style: TextStyle(
                fontFamily: 'TomatoGrotesk',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Main Categories
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemCount: mainCategories.length,
              itemBuilder: (ctx, i) {
                return _buildMainCategory(
                  context,
                  mainCategories[i]['image']!,
                  mainCategories[i]['title']!,
                  i,
                );
              },
            ),

            const SizedBox(height: 28),

            Text(
              'Discover Latest Collection',
              style: TextStyle(
                fontFamily: 'TomatoGrotesk',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 12),

            // Sub Categories
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: subCategories.length,
              itemBuilder: (ctx, i) {
                return _buildSubCategory(
                  context,
                  subCategories[i]['image']!,
                  subCategories[i]['tag']!,
                  isDark,
                );
              },
            ),
          ],
        ),
      ),

      // ✅ Gunakan CustomBottomNav
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }

  Widget _buildMainCategory(BuildContext context, String image, String title, int index) {
    return _CategoryButton(image: image, title: title, index: index);
  }

  Widget _buildSubCategory(BuildContext context, String image, String tag, bool isDark) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductListScreen(title: tag),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.image_not_supported,
                    size: 36,
                    color: isDark ? Colors.grey[600] : Colors.grey,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 16),
              alignment: Alignment.center,
              child: Text(
                tag,
                style: TextStyle(
                  fontFamily: 'TomatoGrotesk',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Hapus _BottomNav lama karena sudah diganti CustomBottomNav

class _CategoryButton extends StatefulWidget {
  final String image;
  final String title;
  final int index;

  const _CategoryButton({
    required this.image,
    required this.title,
    required this.index,
  });

  @override
  State<_CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<_CategoryButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) {
        setState(() => _pressed = false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductListScreen(title: widget.title),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: widget.index == 2
                      ? const LinearGradient(
                          colors: [Color(0xFFFFE082), Color(0xFFF8BBD0)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: widget.index == 0
                      ? const Color(0xFFFF8A80)
                      : (widget.index == 1 ? const Color(0xFFF0F0F0) : null),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: ClipOval(
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.image_not_supported,
                        size: 36,
                        color: isDark ? Colors.grey[600] : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _pressed 
                  ? const Color(0xFFFFD700) 
                  : (isDark ? Colors.grey[850] : Colors.white),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _pressed 
                    ? const Color(0xFFFFD700) 
                    : (isDark ? Colors.grey[700]! : const Color(0xFFE6E6E6)),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              widget.title,
              style: TextStyle(
                fontFamily: 'TomatoGrotesk',
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: _pressed 
                    ? Colors.black 
                    : (isDark ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}