import 'package:flutter/material.dart';
import '../models/Models.dart';


class RecentActivityItem extends StatelessWidget {
  final ActivityItem activity;

  const RecentActivityItem({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildActivityIcon(),
      title: Text(
        activity.title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(activity.description),
          const SizedBox(height: 4),
          Text(
            _formatTimestamp(activity.timestamp),
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Widget _buildActivityIcon() {
    IconData icon;
    Color color;

    switch (activity.type) {
      case 'success':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case 'payment':
        icon = Icons.payment;
        color = Colors.blue;
        break;
      case 'renewal':
        icon = Icons.refresh;
        color = Colors.orange;
        break;
      default:
        icon = Icons.info;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: color,
        size: 20,
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }
}