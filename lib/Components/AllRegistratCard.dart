import'package:flutter/material.dart';

import '../Theme.dart';
class Registrar {
  final String name;
  final String phone;
  final String email;
  final String logo;

  Registrar({
    required this.name,
    required this.phone,
    required this.email,
    required this.logo,
  });
}

class RegistrarCard extends StatelessWidget {
  final Registrar registrar;

  const RegistrarCard({super.key, required this.registrar});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo placeholder (since we don't have actual logos)
            Center(
              child: Icon(
                Icons.business,
                size: 32,
                color: Colors.grey[400],

              ),
            ),

            const SizedBox(height: 12),

            // Company name
            Text(
              registrar.name,
              style: CustomTheme.bodyStyleBold,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 8),

            // Phone
            Row(
              children: [
                const Icon(
                  Icons.phone_outlined,
                  size: 14,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    registrar.phone,
                    style: CustomTheme.bodyStyleSM,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            // Email
            Row(
              children: [
                const Icon(
                  Icons.email_outlined,
                  size: 14,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    registrar.email,
                    style: CustomTheme.bodyStyleSM,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Get Started button
            SizedBox(
              width: double.infinity,


              child: ElevatedButton(
                onPressed: () {
                  _showContactOptions(context, registrar);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF15E33),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showContactOptions(BuildContext context, Registrar registrar) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact ${registrar.name}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Phone option
            ListTile(
              leading: const Icon(Icons.phone, color: Color(0xFFF15E33)),
              title: const Text('Call'),
              subtitle: Text(registrar.phone),
              onTap: () {
                // Implement phone call functionality
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Calling ${registrar.phone}')),
                );
              },
            ),

            // Email option
            ListTile(
              leading: const Icon(Icons.email, color: Color(0xFFF15E33)),
              title: const Text('Email'),
              subtitle: Text(registrar.email),
              onTap: () {
                // Implement email functionality
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening email to ${registrar.email}')),
                );
              },
            ),

            const SizedBox(height: 16),

            // Cancel button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ),
            SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}