import 'package:flutter/material.dart';
import '../models/UserModel.dart';


class DomainOrderCard extends StatelessWidget {
  final DomainOrder domain;

  const DomainOrderCard({Key? key, required this.domain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getStatusColor().withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  domain.domainName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildStatusChip(),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  Icons.calendar_today,
                  'Registered',
                  _formatDate(domain.registrationDate),
                ),
              ),
              Expanded(
                child: _buildInfoItem(
                  Icons.event,
                  'Expires',
                  _formatDate(domain.expiryDate),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  Icons.attach_money,
                  'Price',
                  'KSh ${domain.price.toStringAsFixed(0)}',
                ),
              ),
              Expanded(
                child: _buildInfoItem(
                  Icons.autorenew,
                  'Auto Renewal',
                  domain.autoRenewal ? 'Enabled' : 'Disabled',
                ),
              ),
            ],
          ),

          if (domain.status == 'Expiring Soon' || domain.status == 'Expired') ...[
            const SizedBox(height: 16),
            _buildActionButtons(context),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        domain.status,
        style: TextStyle(
          color: _getStatusColor(),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        if (domain.status == 'Expiring Soon') ...[
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _showRenewalDialog(context),
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Renew Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: () => _toggleAutoRenewal(context),
            child: Text(domain.autoRenewal ? 'Disable Auto' : 'Enable Auto'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            ),
          ),
        ] else if (domain.status == 'Expired') ...[
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _showRenewalDialog(context),
              icon: const Icon(Icons.restore, size: 16),
              label: const Text('Restore Domain'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Color _getStatusColor() {
    switch (domain.status) {
      case 'Active':
        return Colors.green;
      case 'Expiring Soon':
        return Colors.orange;
      case 'Expired':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showRenewalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(domain.status == 'Expired' ? 'Restore Domain' : 'Renew Domain'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Domain: ${domain.domainName}'),
              const SizedBox(height: 8),
              Text('Renewal Price: KSh ${domain.price.toStringAsFixed(0)}'),
              const SizedBox(height: 8),
              Text('New Expiry Date: ${_formatDate(domain.expiryDate.add(const Duration(days: 365)))}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${domain.domainName} renewal initiated!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
              ),
              child: Text(domain.status == 'Expired' ? 'Restore' : 'Renew'),
            ),
          ],
        );
      },
    );
  }

  void _toggleAutoRenewal(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Auto renewal ${domain.autoRenewal ? 'disabled' : 'enabled'} for ${domain.domainName}',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}