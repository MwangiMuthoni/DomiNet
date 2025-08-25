import 'package:flutter/material.dart';
import 'package:ke_domain_connect/Components/MyAppBar.dart';
import 'package:ke_domain_connect/Theme.dart';

import '../Components/AllRegistratCard.dart';

class RegistrarsScreen extends StatefulWidget {
  const RegistrarsScreen({super.key});

  @override
  State<RegistrarsScreen> createState() => _RegistrarsScreenState();
}

class _RegistrarsScreenState extends State<RegistrarsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Registrar> filteredRegistrars = [];

  // Sample registrar data based on the KeNIC page
  final List<Registrar> allRegistrars = [
    Registrar(
      name: 'Truehost Cloud Limited',
      phone: '+254 20 790 3111',
      email: 'info@truehost.co.ke',
      logo: 'assets/images/truehost.png', // You'll need to add actual logo assets
    ),
    Registrar(
      name: 'Kenya Website Experts',
      phone: '0722 209 414',
      email: 'info@kenyawebexperts.co.ke',
      logo: 'assets/images/kwe.png',
    ),
    Registrar(
      name: 'HostPinnacle Cloud Limited',
      phone: '0111054710',
      email: 'info@hostpinnacle.co.ke',
      logo: 'assets/images/hostpinnacle.png',
    ),
    Registrar(
      name: 'HostAfrica EAC',
      phone: '0709 399 000',
      email: 'support@hostafrica.com',
      logo: 'assets/images/hostafrica.png',
    ),
    Registrar(
      name: 'Webhost Kenya',
      phone: '0700337799',
      email: 'info@webhostkenya.co.ke',
      logo: 'assets/images/webhost.png',
    ),
    Registrar(
      name: 'Safaricom Kenya',
      phone: '0722002222',
      email: 'business.support@safaricom.co.ke',
      logo: 'assets/images/safaricom.png',
    ),
    Registrar(
      name: 'Lexsynergy',
      phone: '+44 (0) 20 313 70459',
      email: 'support@lexsynergy.com',
      logo: 'assets/images/lexsynergy.png',
    ),
    Registrar(
      name: 'Afriregister Limited',
      phone: '0724445740',
      email: 'info@afriregister.co.ke',
      logo: 'assets/images/afriregister.png',
    ),
    Registrar(
      name: 'Oracom Web Solutions LTD',
      phone: '+254 713271546',
      email: 'info@oracom.co.ke',
      logo: 'assets/images/oracom.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    filteredRegistrars = allRegistrars;
  }

  void _filterRegistrars(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredRegistrars = allRegistrars;
      } else {
        filteredRegistrars = allRegistrars
            .where((registrar) =>
        registrar.name.toLowerCase().contains(query.toLowerCase()) ||
            registrar.email.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        actions: true,
        backButton: true,
        title: 'Registrars',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 8),
            Text(
              'Find and connect with licensed .ke domain registrars',
              style: CustomTheme.titleStyle,
            ),
            const SizedBox(height: 24),

            // Search Field
            TextField(
              cursorColor: Colors.red,
              controller: _searchController,
              onChanged: _filterRegistrars,
              decoration: InputDecoration(
                hintText: 'Search Registrar...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFFF15E33)),
                ),
                filled: true,
                fillColor: Colors.grey[50],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Results count
            Text(
              '${filteredRegistrars.length} registrars found',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),

            // Registrars Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: filteredRegistrars.length,
              itemBuilder: (context, index) {
                return RegistrarCard(registrar: filteredRegistrars[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}