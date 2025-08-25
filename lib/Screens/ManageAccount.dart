import 'package:flutter/material.dart';
import '../Components/EditForm.dart';
import '../Components/OrderCard.dart';
import '../Theme.dart';
import '../models/UserModel.dart';

class ManageAccountScreen extends StatefulWidget {
  const ManageAccountScreen({Key? key}) : super(key: key);

  @override
  State<ManageAccountScreen> createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isEditing = false;

  // Mock user data - replace with actual data from your backend
  UserModel user = UserModel(
    id: '1',
    name: 'John Doe',
    email: 'john.doe@example.com',
    phone: '+254712345678',
    company: 'Tech Solutions Ltd',
    address: '123 Nairobi Street, Nairobi',
    joinDate: DateTime(2023, 1, 15),
  );

  // Mock domain orders - replace with actual data from your backend
  List<DomainOrder> domainOrders = [
    DomainOrder(
      id: '1',
      domainName: 'techsolutions.co.ke',
      status: 'Active',
      registrationDate: DateTime(2023, 6, 15),
      expiryDate: DateTime(2024, 6, 15),
      price: 1500.0,
      autoRenewal: true,
    ),
    DomainOrder(
      id: '2',
      domainName: 'mystore.ke',
      status: 'Expiring Soon',
      registrationDate: DateTime(2023, 1, 20),
      expiryDate: DateTime(2024, 1, 20),
      price: 1200.0,
      autoRenewal: false,
    ),
    DomainOrder(
      id: '3',
      domainName: 'portfolio.co.ke',
      status: 'Expired',
      registrationDate: DateTime(2022, 8, 10),
      expiryDate: DateTime(2023, 8, 10),
      price: 1500.0,
      autoRenewal: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xAA1A1B1E),
      appBar: AppBar(
        title: const Text('Manage Account'),
        backgroundColor: Color(0xAA1A1B1E),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Color(0xFFF15E33),
          labelColor: Colors.white,
          unselectedLabelColor: Color(0xFF5C5F65),
          tabs: const [
            Tab(text: 'Profile', icon: Icon(Icons.person)),
            Tab(text: 'My Domains', icon: Icon(Icons.language)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProfileTab(),
          _buildDomainsTab(),
        ],
      ),

    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFFF15E33),
                  child: Text(
                    user.name.split(' ').map((e) => e[0]).join().toUpperCase(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Member since ${_formatDate(user.joinDate)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF5C5F65),
                  ),
                ),

              ],
            ),
          ),

          const SizedBox(height: 40),

          // Profile Details
          if (_isEditing)
            ProfileEditForm(
              user: user,
              onSave: (updatedUser) {
                setState(() {
                  user = updatedUser;
                  _isEditing = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Profile updated successfully!'),
                    backgroundColor: Color(0xFFF15E33),
                  ),
                );
              },
              onCancel: () {
                setState(() {
                  _isEditing = false;
                });
              },
            )
          else
            _buildProfileDetails(),
          SizedBox(height: 100,),
        ],
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),

        _buildDetailCard(Icons.email, 'Email', user.email),
        const SizedBox(height: 16),

        _buildDetailCard(Icons.phone, 'Phone', user.phone),
        const SizedBox(height: 16),

        _buildDetailCard(Icons.business, 'Company', user.company),
        const SizedBox(height: 16),

        _buildDetailCard(Icons.location_on, 'Address', user.address),
        SizedBox(height: 200,)
      ],
    );
  }

  Widget _buildDetailCard(IconData icon, String label, String value) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xAA1A1B1E),
        border: Border.all(color: Color(0xFF373A3F)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFF15E33).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Color(0xFFF15E33),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF5C5F65),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDomainsTab() {
    // Group domains by status
    final activeDomains = domainOrders.where((d) => d.status == 'Active').toList();
    final expiringSoon = domainOrders.where((d) => d.status == 'Expiring Soon').toList();
    final expiredDomains = domainOrders.where((d) => d.status == 'Expired').toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          const SizedBox(height: 16),

            const SizedBox(height: 12),
            ...expiringSoon.map((domain) => _buildDomainCard(domain)),
            const SizedBox(height: 24),

          const SizedBox(height: 12),
            ...expiredDomains.map((domain) => _buildDomainCard(domain)),
            const SizedBox(height: 24),


            const SizedBox(height: 12),
            ...activeDomains.map((domain) => _buildDomainCard(domain)),
          SizedBox(height: 200,)
        ],
      ),
    );
  }

  Widget _buildDomainCard(DomainOrder domain) {
    Color statusColor;
    switch (domain.status) {
      case 'Active':
        statusColor = Colors.green;
        break;
      case 'Expiring Soon':
        statusColor = Colors.orange;
        break;
      case 'Expired':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Color(0xFF5C5F65);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xAA1A1B1E),
        border: Border.all(color: Color(0xFF373A3F)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  domain.domainName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                domain.status,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildDomainDetail('Registration', _formatDate(domain.registrationDate)),
              ),
              Expanded(
                child: _buildDomainDetail('Expiry', _formatDate(domain.expiryDate)),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildDomainDetail('Price', 'KSH ${domain.price.toStringAsFixed(0)}'),
              ),
              Expanded(
                child: _buildDomainDetail('Auto Renewal', domain.autoRenewal ? 'Enabled' : 'Disabled'),
              ),
            ],
          ),

          if (domain.status == 'Expiring Soon' || domain.status == 'Expired') ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                onPressed: () {
                  // Handle renewal
                },
                color: Color(0xFFF15E33),
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  domain.status == 'Expired' ? 'Renew Domain' : 'Extend Registration',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDomainDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF5C5F65),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }



  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}