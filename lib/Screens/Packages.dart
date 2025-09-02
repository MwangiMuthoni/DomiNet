import 'package:flutter/material.dart';

class HostingPackagesScreen extends StatefulWidget {
  const HostingPackagesScreen({Key? key}) : super(key: key);

  @override
  _HostingPackagesScreenState createState() => _HostingPackagesScreenState();
}

class _HostingPackagesScreenState extends State<HostingPackagesScreen> {
  Map<String, dynamic>? selectedPackage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Choose Hosting Package'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Grid of packages in rows of 2
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
              children: [
                _buildPackageCard(
                  title: 'Basic',
                  price: 2500.0,
                  period: 'Year',
                  features: ['10 Sites', '30GB Space', 'Free SSL'],
                  isPopular: false,
                ),
                _buildPackageCard(
                  title: 'Pro',
                  price: 840.0,
                  period: 'Month',
                  features: ['30 Sites', '50GB Space', 'Free SSL'],
                  isPopular: true,
                ),
              ],
            ),

            SizedBox(height: 20),

            // Order Summary Section
            if (selectedPackage != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Color(0xFFF15E33),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Summary',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 24),

                    // Package details
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Web Hosting - ${selectedPackage!['title']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          'Ksh ${selectedPackage!['price'].toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Billing period
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Recurring ${selectedPackage!['period']}ly',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Ksh ${selectedPackage!['price'].toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // VAT
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Kenyan VAT @ 16.00%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Ksh ${(selectedPackage!['price'] * 0.16).toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // Total
                    Text(
                      'Total Due Today',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Ksh ${(selectedPackage!['price'] * 1.16).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 24),

                    // Continue button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Processing payment...'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.9),
                          foregroundColor: Color(0xFFF15E33),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_forward, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],

            // Support
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.help, color: Color(0xFFF15E33)),
                  const SizedBox(width: 12),
                  Text('Need help?', style: TextStyle(fontSize: 14)),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Call: 0700 000 000')),
                      );
                    },
                    child: Text('Contact', style: TextStyle(color: Color(0xFFF15E33))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build package card with select functionality
  Widget _buildPackageCard({
    required String title,
    required double price,
    required String period,
    required List<String> features,
    required bool isPopular,
  }) {
    bool isSelected = selectedPackage != null && selectedPackage!['title'] == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPackage = {
            'title': title,
            'price': price,
            'period': period,
            'features': features,
          };
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: Color(0xFFF15E33), width: 3)
              : isPopular
              ? Border.all(color: Color(0xFFF15E33), width: 2)
              : Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isPopular)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFFF15E33),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Popular',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: Color(0xFFF15E33),
                    size: 24,
                  ),
              ],
            ),
            if (isPopular || isSelected) SizedBox(height: 8),

            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4),

            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Ksh ${price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF15E33),
                    ),
                  ),
                  TextSpan(
                    text: '/$period',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),

            // Features
            ...features.map((feature) => Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Icon(Icons.check, size: 16, color: Colors.green),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feature,
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}