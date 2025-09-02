import 'package:flutter/material.dart';
import 'package:ke_domain_connect/Components/MyAppBar.dart';
import 'package:ke_domain_connect/Components/MyEndDrawer.dart';

import '../Theme.dart';

// Data models
class Customer {
  final String name;
  final String email;
  final String phone;
  final String company;
  final int domains;
  final int active;
  final int spent;
  final String status;

  Customer({
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
    required this.domains,
    required this.active,
    required this.spent,
    required this.status,
  });
}

class Domain {
  final String name;
  final String status;
  final String expiry;

  Domain({required this.name, required this.status, required this.expiry});
}

class RegistrarCustomersScreen extends StatefulWidget {
  const RegistrarCustomersScreen({Key? key}) : super(key: key);

  @override
  State<RegistrarCustomersScreen> createState() => _RegistrarCustomersScreenState();
}

class _RegistrarCustomersScreenState extends State<RegistrarCustomersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';



  final List<Customer> _customers = [
    Customer(
      name: 'Grace Wanjiku',
      email: 'gwanjiku@safaritech.co.ke',
      phone: '+254 722 345 678',
      company: 'Safari Tech Solutions',
      domains: 4,
      active: 3,
      spent: 18500,
      status: 'Active',
    ),
    Customer(
      name: 'David Kipchoge',
      email: 'dkipchoge@runnerscorp.ke',
      phone: '+254 733 456 789',
      company: 'Runners Corporation',
      domains: 7,
      active: 5,
      spent: 42000,
      status: 'Premium',
    ),
    Customer(
      name: 'Mary Achieng',
      email: 'machieng@lakevictoria.co.ke',
      phone: '+254 701 234 567',
      company: 'Lake Victoria Trading',
      domains: 2,
      active: 1,
      spent: 12000,
      status: 'Expiring',
    ),
    Customer(
      name: 'James Mwangi',
      email: 'jmwangi@technairobi.ke',
      phone: '+254 712 345 678',
      company: 'Tech Nairobi Ltd',
      domains: 5,
      active: 5,
      spent: 28000,
      status: 'Active',
    ),
    Customer(
      name: 'Susan Njeri',
      email: 'snjeri@kikuyufarms.co.ke',
      phone: '+254 720 987 654',
      company: 'Kikuyu Organic Farms',
      domains: 3,
      active: 2,
      spent: 15500,
      status: 'Active',
    ),
  ];

  final List<Domain> _domains = [
    Domain(name: 'safaritech.co.ke', status: 'Active', expiry: 'Dec 15, 2024'),
    Domain(name: 'runnerscorp.ke', status: 'Active', expiry: 'Mar 22, 2025'),
    Domain(name: 'lakevictoria.co.ke', status: 'Expiring', expiry: 'Sep 8, 2024'),
    Domain(name: 'technairobi.ke', status: 'Active', expiry: 'Jan 30, 2025'),
    Domain(name: 'kikuyufarms.co.ke', status: 'Active', expiry: 'Nov 12, 2024'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Customer> get filteredCustomers {
    List<Customer> filtered = _customers;


    if (_searchController.text.isNotEmpty) {
      filtered = filtered.where((customer) =>
      customer.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
          customer.company.toLowerCase().contains(_searchController.text.toLowerCase()) ||
          customer.email.toLowerCase().contains(_searchController.text.toLowerCase())
      ).toList();
    }

    // Apply status filter
    if (_selectedFilter != 'All') {
      if (_selectedFilter == 'High Value') {
        filtered = filtered.where((customer) => customer.spent > 20000).toList();
      } else {
        filtered = filtered.where((customer) => customer.status == _selectedFilter).toList();
      }
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: MyAppBar(actions: true, backButton: true,title: 'Registrar Dashboard',),
      endDrawer:  EndDrawer(),
      body: Column(
        children: [
          SizedBox(height: 60,),
          _buildSearchAndFilter(),
          Expanded(child: _buildCustomersList()),

        ],
      ),

    );
  }


  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search customers...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
                onChanged: (value) => setState(() {}),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: DropdownButton<String>(
              value: _selectedFilter,
              underline: const SizedBox(),
              icon: Icon(Icons.filter_list, color: Colors.grey[600]),
              items: ['All', 'Active', 'Premium', 'Expiring', 'High Value']
                  .map((value) => DropdownMenuItem(
                value: value,
                child: Text(value,  style: CustomTheme.bodyStyleBold,),
              ))
                  .toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedFilter = newValue;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomersList() {
    final customers = filteredCustomers;

    if (customers.isEmpty) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No customers found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 200,),
          ],
        ),
      );

    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: customers.length,
      itemBuilder: (context, index) => _buildCustomerCard(customers[index]),
    );
  }

  Widget _buildCustomerCard(Customer customer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _showCustomerDetails(customer),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Text(
                        _getInitials(customer.name),
                        style: CustomTheme.titleStyle
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer.name,
                            style: CustomTheme.bodyStyleBold,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          customer.company,
                            style: CustomTheme.bodyStyle
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(customer.status),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.email_outlined, size: 14, color: Colors.grey[500]),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      customer.email,
                        style: CustomTheme.bodyStyleSM,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.phone_outlined, size: 14, color: Colors.grey[500]),
                  const SizedBox(width: 6),
                  Text(
                    customer.phone,
                    style: CustomTheme.bodyStyleSM,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildInfoChip('${customer.domains} domains', Colors.grey[600]!),
                  const SizedBox(width: 8),
                  _buildInfoChip('${customer.active} active', Colors.green),
                  const Spacer(),
                  Text(
                    'KSh ${customer.spent.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                    style: CustomTheme.bodyStylegreen,
                  ),
                ],
              ),

            ],
          ),
        ),
      ),

    );
  }


  Widget _buildStatusBadge(String status) {
    Color bgColor, textColor;

    switch (status) {
      case 'Active':

        break;
      case 'Premium':
        break;
      case 'Expiring':

        break;
      default:
        bgColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey[600]!;
    }

    return Text(
      status,
      style: CustomTheme.bodyStyle,
    );
  }

  Widget _buildInfoChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3), width: 0.5),
      ),
      child: Text(
        text,
        style: CustomTheme.bodyStyleSM,
      ),
    );
  }

  String _getInitials(String name) {
    return name
        .split(' ')
        .where((word) => word.isNotEmpty)
        .take(2)
        .map((word) => word[0].toUpperCase())
        .join();
  }

  void _showCustomerDetails(Customer customer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildCustomerHeader(customer),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contact Details',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(Icons.email_outlined, 'Email', customer.email),
                    _buildDetailRow(Icons.phone_outlined, 'Phone', customer.phone),
                    _buildDetailRow(Icons.business_outlined, 'Company', customer.company),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Domains',
                          style: CustomTheme.titleStyle,
                        ),
                        Text(
                          '${customer.domains} total',
                          style: CustomTheme.titleStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...List.generate(
                      customer.domains,
                          (index) => _buildDomainItem(_domains[index % _domains.length]),
                    ),
                    SizedBox(height: 200,),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildCustomerHeader(Customer customer) {
    return Row(
      children: [
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              _getInitials(customer.name),
              style: CustomTheme.titleStyle,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customer.name,
                style: CustomTheme.titleStyle,
              ),
              const SizedBox(height: 2),
              Text(
                customer.company,
                style: CustomTheme.bodyStyle,
              ),
              const SizedBox(height: 4),
              Text(
                'Total Spent KSh ${customer.spent.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} ',
                style: CustomTheme.bodyStylegreen,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: Colors.grey[600]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: CustomTheme.bodyStyle,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: CustomTheme.bodyStyleSM,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDomainItem(Domain domain) {
    final isActive = domain.status == 'Active';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[50],
      ),
      child: Row(
        children: [

          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  domain.name,
                  style: CustomTheme.bodyStyle,
                ),
                const SizedBox(height: 2),
                Text(
                  'Expires ${domain.expiry}',
                  style: CustomTheme.bodyStyleSM,
                ),
              ],
            ),
          ),
          Text(
            domain.status,
            style: CustomTheme.bodyStyle,
          ),
        ],
      ),
    );
  }
}