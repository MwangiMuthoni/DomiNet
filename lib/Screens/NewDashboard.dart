import 'package:flutter/material.dart';
import 'package:ke_domain_connect/Components/MyAppBar.dart';
import 'package:ke_domain_connect/Components/MyEndDrawer.dart';
import '../Theme.dart';

// Data models for onboarding steps
class OnboardingStep {
  final String title;
  final String description;
  final IconData icon;
  final bool isCompleted;
  final bool isOptional;

  OnboardingStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.isCompleted,
    this.isOptional = false,
  });
}

class QuickAction {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  QuickAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class NewRegistrarDashboardScreen extends StatefulWidget {
  const NewRegistrarDashboardScreen({Key? key}) : super(key: key);

  @override
  State<NewRegistrarDashboardScreen> createState() => _NewRegistrarDashboardScreenState();
}

class _NewRegistrarDashboardScreenState extends State<NewRegistrarDashboardScreen> {

  // Sample registrar info - this would come from your backend
  final String registrarName = "Tech Solutions Kenya Ltd";
  final String registrarId = "REG-001234";
  final DateTime verificationDate = DateTime.now().subtract(Duration(days: 2));
  final double accountBalance = 0.0;

  // Onboarding progress
  final List<OnboardingStep> onboardingSteps = [
    OnboardingStep(
      title: 'Account Setup Complete',
      description: 'Your registrar account has been verified and activated',
      icon: Icons.verified_user,
      isCompleted: true,
    ),
    OnboardingStep(
      title: 'Configure EPP Connection',
      description: 'Set up your EPP client to connect with KENIC registry',
      icon: Icons.cable,
      isCompleted: false,
    ),
    OnboardingStep(
      title: 'Add Funds to Account',
      description: 'Deposit funds to start registering domains for clients',
      icon: Icons.account_balance_wallet,
      isCompleted: false,
    ),
    OnboardingStep(
      title: 'Test Domain Registration',
      description: 'Register your first test domain to verify everything works',
      icon: Icons.domain,
      isCompleted: false,
    ),
    OnboardingStep(
      title: 'Setup Client Portal',
      description: 'Configure your client-facing domain management system',
      icon: Icons.web,
      isCompleted: false,
      isOptional: true,
    ),
    OnboardingStep(
      title: 'Configure Billing System',
      description: 'Set up automated billing and invoicing for your clients',
      icon: Icons.receipt_long,
      isCompleted: false,
      isOptional: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: MyAppBar(
        actions: true,
        backButton: true,
        title: 'New Registrar Dashboard',
      ),
      endDrawer: EndDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildWelcomeCard(),
            SizedBox(height: 20),
            _buildAccountStatusCard(),
            SizedBox(height: 20),
            _buildOnboardingProgress(),
            SizedBox(height: 20),
            _buildQuickActions(),
            SizedBox(height: 20),
            _buildSupportCard(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[600]!, Colors.green[400]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.celebration,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to KENIC!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'You\'re now a verified .ke domain registrar',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Congratulations on becoming a KENIC-accredited registrar! Follow the steps below to complete your setup and start offering .ke domains to your clients.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountStatusCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Information',
            style: CustomTheme.titleStyle,
          ),
          SizedBox(height: 16),
          _buildInfoRow('Registrar Name', registrarName),
          _buildInfoRow('Registrar ID', registrarId),
          _buildInfoRow('Verified On', _formatDate(verificationDate)),
          _buildInfoRow('Account Balance', 'KSh ${accountBalance.toStringAsFixed(2)}'),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.orange[700], size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Add funds to your account to start registering domains',
                    style: TextStyle(
                      color: Colors.orange[700],
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: CustomTheme.bodyStyle,
            ),
          ),
          Text(': ', style: CustomTheme.bodyStyle),
          Expanded(
            child: Text(
              value,
              style: CustomTheme.bodyStyleBold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingProgress() {
    final completedSteps = onboardingSteps.where((step) => step.isCompleted).length;
    final totalSteps = onboardingSteps.length;
    final progress = completedSteps / totalSteps;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Setup Progress', style: CustomTheme.titleStyle),
                    Text('$completedSteps/$totalSteps', style: CustomTheme.bodyStyleBold),
                  ],
                ),
                SizedBox(height: 12),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ],
            ),
          ),
          ...onboardingSteps.map((step) => _buildOnboardingStep(step)).toList(),
        ],
      ),
    );
  }

  Widget _buildOnboardingStep(OnboardingStep step) {
    return InkWell(
      onTap: step.isCompleted ? null : () => _handleStepTap(step),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[100]!),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: step.isCompleted
                    ? Colors.green
                    : step.isOptional
                    ? Colors.blue[50]
                    : Colors.orange[50],
                borderRadius: BorderRadius.circular(20),
                border: step.isCompleted
                    ? null
                    : Border.all(
                    color: step.isOptional
                        ? Colors.blue[200]!
                        : Colors.orange[200]!
                ),
              ),
              child: Icon(
                step.isCompleted ? Icons.check : step.icon,
                color: step.isCompleted
                    ? Colors.white
                    : step.isOptional
                    ? Colors.blue[600]
                    : Colors.orange[600],
                size: 20,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          step.title,
                          style: step.isCompleted
                              ? CustomTheme.bodyStyle.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[600],
                          )
                              : CustomTheme.bodyStyleBold,
                        ),
                      ),
                      if (step.isOptional)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Optional',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.blue[700],
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    step.description,
                    style: CustomTheme.bodyStyleSM,
                  ),
                ],
              ),
            ),
            if (!step.isCompleted)
              Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      QuickAction(
        title: 'Add Funds',
        subtitle: 'Deposit money to register domains',
        icon: Icons.add_circle,
        color: Colors.green,
        onTap: () => _showAddFundsDialog(),
      ),
      QuickAction(
        title: 'EPP Setup Guide',
        subtitle: 'Configure your EPP connection',
        icon: Icons.integration_instructions,
        color: Colors.blue,
        onTap: () => _showEPPGuide(),
      ),
      QuickAction(
        title: 'Documentation',
        subtitle: 'Read the registrar handbook',
        icon: Icons.menu_book,
        color: Colors.orange,
        onTap: () => _openDocumentation(),
      ),
      QuickAction(
        title: 'Contact Support',
        subtitle: 'Get help from KENIC team',
        icon: Icons.support_agent,
        color: Colors.purple,
        onTap: () => _contactSupport(),
      ),
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Actions', style: CustomTheme.titleStyle),
          SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: actions.length,
            itemBuilder: (context, index) => _buildQuickActionCard(actions[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(QuickAction action) {
    return InkWell(
      onTap: action.onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: action.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                action.icon,
                color: action.color,
                size: 22,
              ),
            ),
            SizedBox(height: 12),
            Text(
              action.title,
              style: CustomTheme.bodyStyleBold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(
              action.subtitle,
              style: CustomTheme.bodyStyleSM,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Need Help?', style: CustomTheme.titleStyle),
          SizedBox(height: 12),
          Text(
            'Our technical team is here to help you get started. Contact us for assistance with setup, EPP configuration, or any questions about managing domains.',
            style: CustomTheme.bodyStyle,
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _contactSupport(),
                  icon: Icon(Icons.email),
                  label: Text('Email Support'),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _scheduleCall(),
                  icon: Icon(Icons.phone),
                  label: Text('Schedule Call'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _handleStepTap(OnboardingStep step) {
    switch (step.title) {
      case 'Configure EPP Connection':
        _showEPPGuide();
        break;
      case 'Add Funds to Account':
        _showAddFundsDialog();
        break;
      case 'Test Domain Registration':
        _showTestRegistration();
        break;
      default:
        _showStepDetails(step);
    }
  }

  void _showEPPGuide() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('EPP Setup Guide'),
        content: Text('EPP configuration guide will be provided here. This would include connection details, sample code, and testing instructions.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAddFundsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Funds'),
        content: Text('Fund addition interface would be implemented here with payment integration.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Add Funds'),
          ),
        ],
      ),
    );
  }

  void _showTestRegistration() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Test Domain Registration'),
        content: Text('Test domain registration interface would be provided here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showStepDetails(OnboardingStep step) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(step.title),
        content: Text(step.description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _openDocumentation() {
    // Would open documentation in browser or in-app
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening registrar documentation...')),
    );
  }

  void _contactSupport() {
    // Would open email client or support chat
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening support contact...')),
    );
  }

  void _scheduleCall() {
    // Would open calendar scheduling interface
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening call scheduling...')),
    );
  }
}