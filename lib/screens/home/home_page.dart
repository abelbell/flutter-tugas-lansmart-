// lib/screens/home/home_page.dart
import 'package:flutter/material.dart';

// Widgets untuk halaman Home
import 'widgets/custom_search_bar.dart';
import 'widgets/banner_section.dart';
import 'widgets/section_title.dart';
import 'widgets/category_chips.dart';
import 'widgets/product_grid.dart';
import 'widgets/filter_content.dart';

// Komponen global
import '../../widgets/custom/app_drawer.dart';
import '../../widgets/custom/custom_bottom_nav.dart';
import '../../screens/notifications/notifications_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _selectedCategory = 'All';
  final List<String> categories = ['All', 'Child', 'Men', 'Women', 'Dress', 'Unisex'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: const AppDrawer(), // const OK karena widgetnya Stateless
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(onFilterPressed: _showFilter), // FIXED
            const BannerSection(),
            const SizedBox(height: 24),
            const SectionTitle("Let's Get Started!"),
            const SizedBox(height: 16),
            CategoryChips(
              categories: categories,
              selected: _selectedCategory,
              onSelected: (cat) => setState(() => _selectedCategory = cat),
            ),
            const SizedBox(height: 20),
            const ProductGrid(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }

  void _showFilter() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (_, controller) => SingleChildScrollView(
          controller: controller,
          child: const FilterContent(),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Image.asset(
        'assets/images/logo-dark.png',
        width: 40,
        height: 40,
        fit: BoxFit.contain,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.black),
          onPressed: () {
            Navigator.pushNamed(context, '/notifications');
          },
        ),
      ],
    );
  }
}