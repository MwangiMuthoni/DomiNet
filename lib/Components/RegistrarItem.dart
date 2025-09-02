import 'package:flutter/material.dart';
import 'package:ke_domain_connect/Theme.dart';

import '../Screens/BuyNow.dart';
import '../Screens/Packages.dart';

class RegistrarItem extends StatelessWidget {
  final String companyName;
  final String email;
  final String phone;
  final String tld;
  final String price;

  const RegistrarItem({
    super.key,
    required this.companyName,
    required this.email,
    required this.phone,
    required this.tld,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Domain name
          Text(
            tld,
            style: CustomTheme.bodyStylegreen,
          ),
          const SizedBox(height: 6),

          // Company name
          Text(
            companyName,
            style: CustomTheme.bodyStyle,
          ),
          const SizedBox(height: 8),

          // Contact info
          Row(
            children: [
              const Icon(
                Icons.email_outlined,
                size: 16,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              Text(
                email,
                style: CustomTheme.bodyStyle,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(
                Icons.phone_outlined,
                size: 16,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              Text(
                phone,
                style: CustomTheme.bodyStyle,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Price: Ksh $price',
            style: CustomTheme.bodyStyleRedBold,
          ),
          const SizedBox(height: 12),

          // Buy Now button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HostingPackagesScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF15E33),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Buy Now',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}