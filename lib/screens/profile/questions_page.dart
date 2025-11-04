import 'package:flutter/material.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  // Track which FAQ is expanded
  int? _expandedIndex;

  final List<Map<String, String>> faqs = [
    {
      "question": "What is included with my purchase?",
      "answer":
      "Packages have the HTML files, SCSS files, CSS files, JS files, Well Define Documentation, Fonts and Icons, Responsive Designs, Image Assets, Customization Options, and many more."
    },
    {
      "question": "What features does LensMart offer?",
      "answer": "LensMart offers a wide range of features including customizable templates, responsive design, SEO optimization, and more."
    },
    {
      "question": "Can I customize the template's design?",
      "answer": "Yes, you can fully customize the design using SCSS, HTML, and CSS files provided in the package."
    },
    {
      "question": "Is the template SEO-friendly?",
      "answer": "Yes, the template is built with SEO best practices in mind."
    },
    {
      "question": "Are there pre-designed page templates included?",
      "answer": "Yes, multiple pre-designed page templates are included for home, about, contact, and more."
    },
    {
      "question": "Does LensMart provide customer support?",
      "answer": "Yes, we offer dedicated customer support to help you with any issues."
    },
    {
      "question": "Is coding knowledge required to use LensMart?",
      "answer": "Basic HTML/CSS knowledge is helpful, but not strictly required for simple customizations."
    },
    {
      "question": "How can I get started with LensMart?",
      "answer": "Download the package, read the documentation, and start editing the HTML/SCSS files to match your brand."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'FAQ',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final isExpanded = _expandedIndex == index;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // Question Header
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    setState(() {
                      _expandedIndex = isExpanded ? null : index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            faqs[index]["question"]!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        AnimatedRotation(
                          turns: isExpanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Answer Body (Animated)
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      faqs[index]["answer"]!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                  ),
                  crossFadeState: isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 200),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}