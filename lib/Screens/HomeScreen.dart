import 'package:flutter/material.dart';
import 'package:ke_domain_connect/Components/MyAppBar.dart';
import 'package:ke_domain_connect/Theme.dart';

import '../Components/MyEndDrawer.dart';
import 'SearchResult.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  String selectedTld = '.ke';

  // List of available TLDs
  final List<String> tldOptions = [
    '.ke',
    '.co.ke',
    '.sc.ke',
    '.ne.ke',
    '.ac.ke',
    '.mobi.ke',
    '.or.ke',
    '.me.ke',
    '.info.ke',
  ];

  void performSearch() {
    if (searchController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsScreen(
            searchQuery: searchController.text,
            selectedTld: selectedTld,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        actions: true,
        backButton: false,
        title: 'Domain Marketplace',
      ),
      endDrawer: EndDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Main heading with gradient
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: CustomTheme.titleStyle,
                children: [
                  const TextSpan(
                    text: 'Find Your Perfect\n',
                    style: TextStyle(color: Colors.black87),
                  ),
                  TextSpan(
                    text: '.KE Domain',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Description text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Compare prices, register with M-Pesa, and manage all your .ke domains in one place.',
                textAlign: TextAlign.center,
                style: CustomTheme.bodyStyle,
              ),
            ),

            const SizedBox(height: 40),

            // Search section with integrated TLD dropdown
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                cursorColor: Color(0xFFF15E33),
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Enter domain name...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // TLD Dropdown
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedTld,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedTld = newValue!;
                              });
                            },
                            items: tldOptions.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                    fontSize: 15,
                                  ),
                                ),
                              );
                            }).toList(),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black54,
                              size: 24,
                            ),
                            dropdownColor: Colors.white,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              fontSize: 15,
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                      // Search button
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF15E33),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.all(8),
                        child: IconButton(
                          icon: const Icon(Icons.search, color: Colors.white, size: 24),
                          onPressed: performSearch,
                        ),
                      ),
                    ],
                  ),
                ),
                onSubmitted: (value) => performSearch(),
              ),
            ),

            const SizedBox(height: 48),

            // Empty state illustration
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.search_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Start your domain search',
                  textAlign: TextAlign.center,
                  style: CustomTheme.titleStyle,
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Enter a domain name above and select your preferred extension to see available options from verified registrars',
                    textAlign: TextAlign.center,
                    style: CustomTheme.bodyStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}