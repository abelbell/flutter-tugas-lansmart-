// lib/screens/components/components_page.dart
import 'package:flutter/material.dart';

class ComponentDetailPage extends StatelessWidget {
  final String title;
  
  const ComponentDetailPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        backgroundColor: isDark ? Colors.grey[850] : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'TomatoGrotesk',
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.widgets_outlined,
              size: 80,
              color: const Color(0xFFFFA726),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'TomatoGrotesk',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This component is under development',
              style: TextStyle(
                fontFamily: 'TomatoGrotesk',
                fontSize: 14,
                color: isDark ? Colors.white60 : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccordionPage extends StatelessWidget {
  const AccordionPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const ComponentDetailPage(title: 'Accordion');
}

class AlertsPage extends StatelessWidget {
  const AlertsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const ComponentDetailPage(title: 'Alerts');
}

class BadgesPage extends StatelessWidget {
  const BadgesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const ComponentDetailPage(title: 'Badges');
}

class BreadcrumbPage extends StatelessWidget {
  const BreadcrumbPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const ComponentDetailPage(title: 'Breadcrumb');
}

class ButtonsPage extends StatelessWidget {
  const ButtonsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const ComponentDetailPage(title: 'Buttons');
}

class ButtonGroupPage extends StatelessWidget {
  const ButtonGroupPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const ComponentDetailPage(title: 'Button Group');
}

class CardsPage extends StatelessWidget {
  const CardsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const ComponentDetailPage(title: 'Cards');
}

class CarouselPage extends StatelessWidget {
  const CarouselPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const ComponentDetailPage(title: 'Carousel');
}

class CollapsePage extends StatelessWidget {
  const CollapsePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const ComponentDetailPage(title: 'Collapse');
}

class DropdownsPage extends StatelessWidget {
  const DropdownsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const ComponentDetailPage(title: 'Dropdowns');
}

class UiFormsPage extends StatelessWidget {
  const UiFormsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const ComponentDetailPage(title: 'Ui Forms');
}

class InputGroupsPage extends StatelessWidget {
  const InputGroupsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const ComponentDetailPage(title: 'Input Groups');
}

class FloatingLabelsPage extends StatelessWidget {
  const FloatingLabelsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const ComponentDetailPage(title: 'Floating Labels');
}

class SelectPage extends StatelessWidget {
  const SelectPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const ComponentDetailPage(title: 'Select');
}

class CheckRadioPage extends StatelessWidget {
  const CheckRadioPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const ComponentDetailPage(title: 'Check & Radio');
}

class SwitchPage extends StatelessWidget {
  const SwitchPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const ComponentDetailPage(title: 'Switch');
}

// ========================================
// COMPONENTS PAGE (MAIN)
// ========================================

class ComponentsPage extends StatelessWidget {
  const ComponentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        backgroundColor: isDark ? Colors.grey[850] : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Components',
          style: TextStyle(
            fontFamily: 'TomatoGrotesk',
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // UI COMPONENTS SECTION
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFA726),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.widgets,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Ui Components',
                      style: TextStyle(
                        fontFamily: 'TomatoGrotesk',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // UI COMPONENTS LIST
              Container(
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[850] : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildComponentItem(context, 'Accordion', () => _navigateTo(context, const AccordionPage())),
                    _buildDivider(isDark),
                    _buildComponentItem(context, 'Alerts', () => _navigateTo(context, const AlertsPage())),
                    _buildDivider(isDark),
                    _buildComponentItem(context, 'Badges', () => _navigateTo(context, const BadgesPage())),
                    _buildDivider(isDark),
                    _buildComponentItem(context, 'Breadcrumb', () => _navigateTo(context, const BreadcrumbPage())),
                    _buildDivider(isDark),
                    _buildComponentItem(context, 'Buttons', () => _navigateTo(context, const ButtonsPage())),
                    _buildDivider(isDark),
                    _buildComponentItem(context, 'Button group', () => _navigateTo(context, const ButtonGroupPage())),
                    _buildDivider(isDark),
                    _buildComponentItem(context, 'Cards', () => _navigateTo(context, const CardsPage())),
                    _buildDivider(isDark),
                    _buildComponentItem(context, 'Carousel', () => _navigateTo(context, const CarouselPage())),
                    _buildDivider(isDark),
                    _buildComponentItem(context, 'Collapse', () => _navigateTo(context, const CollapsePage())),
                    _buildDivider(isDark),
                    _buildComponentItem(context, 'Dropdowns', () => _navigateTo(context, const DropdownsPage())),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // UI FORMS ELEMENT SECTION
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFA726),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.format_align_left,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Ui Forms Element',
                      style: TextStyle(
                        fontFamily: 'TomatoGrotesk',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // UI FORMS LIST
              Container(
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[850] : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildComponentItem(context, 'Ui Forms', () => _navigateTo(context, const UiFormsPage())),
                    _buildDivider(isDark),
                    _buildComponentItem(context, 'Input Groups', () => _navigateTo(context, const InputGroupsPage())),
                    _buildDivider(isDark),
                    _buildComponentItem(context, 'Floating Labels', () => _navigateTo(context, const FloatingLabelsPage())),
                    _buildDivider(isDark),
                    _buildComponentItem(context, 'Select', () => _navigateTo(context, const SelectPage())),
                    _buildDivider(isDark),
                    _buildComponentItem(context, 'Check & Radio', () => _navigateTo(context, const CheckRadioPage())),
                    _buildDivider(isDark),
                    _buildComponentItem(context, 'Switch', () => _navigateTo(context, const SwitchPage())),
                  ],
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Widget _buildComponentItem(BuildContext context, String title, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFFA726),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'B',
                  style: TextStyle(
                    fontFamily: 'TomatoGrotesk',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'TomatoGrotesk',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDark ? Colors.white60 : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 72,
      color: isDark ? Colors.grey[700] : const Color(0xFFE0E0E0),
    );
  }
}