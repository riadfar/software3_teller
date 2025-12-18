import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class TellerHeader extends StatelessWidget {
  final String tellerName;
  const TellerHeader({super.key, required this.tellerName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Teller Dashboard",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.navy,
                    fontFamily: 'Roboto Slab',
                  ),
                ),
                const SizedBox(width: 10),
                _buildStatusBadge(),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Teller Name: $tellerName",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green),
      ),
      child: const Row(
        children: [
          CircleAvatar(radius: 3, backgroundColor: Colors.green),
          SizedBox(width: 6),
          Text(
            "ONLINE",
            style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}