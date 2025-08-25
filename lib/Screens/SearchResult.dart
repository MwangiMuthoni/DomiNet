import 'package:flutter/material.dart';

import '../Components/DomainSuggestionItem.dart';
import '../Components/RegistrarItem.dart';
import '../Theme.dart';
import 'AllRegistrars.dart';

class SearchResultsScreen extends StatefulWidget {
  final String searchQuery;
  final String? selectedTld;

  const SearchResultsScreen({
    super.key,
    required this.searchQuery,
    this.selectedTld,
  });

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  String? selectedDomain;

  @override
  void initState() {
    super.initState();
    // Auto-select the domain with the TLD from home screen if provided
    if (widget.selectedTld != null) {
      selectedDomain = '${widget.searchQuery}${widget.selectedTld}';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Domain Search Results'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search query display with selected TLD
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Search results for: ${widget.searchQuery} ${widget.selectedTld}',
                style: CustomTheme.titleStyle,
              ),
            ),



            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Available Registrars',
                  style: CustomTheme.titleStyle,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  RegistrarsScreen (), // replace with your page
                      ),
                    );
                  },
                  child: const Text(
                    'See all',
                    style: CustomTheme.titleStyle,
                  ),
                ),

              ],
            ),
            const SizedBox(height: 12),

            // Registrar details (only show if a domain is selected)
            if (selectedDomain != null) ...[
              RegistrarItem(
                companyName: 'Hostpinnacle Kenya Limited',
                email: 'info@hostpinnacle.co.ke',
                phone: '011 054 710',
                tld: selectedDomain!,
                price: '3000 ',
              ),
              RegistrarItem(
                companyName: 'TrueRest Cloud Limited',
                email: 'info@truehost.co.ke',
                phone: '072491916',
                tld: selectedDomain!,
                price: '900  ',
              ),
              RegistrarItem(
                companyName: 'EAC directory',
                email: 'suppent@hotosirico.com',
                phone: '0705919000',
                tld: selectedDomain!,
                price: '2000  ',
              ),
              RegistrarItem(
                companyName: 'Safaricom Limited',
                email: 'business.sappant@safaricom.co.ke',
                phone: '0722002222',
                tld: selectedDomain!,
                price: '1500  ',
              ),
            ] else ...[
              // Prompt to select a domain
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(

                  child: Text(
                    'Select a domain extension to see available registrars',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
            SizedBox(height: 200,)
          ],
        ),

      ),
    );
  }
}