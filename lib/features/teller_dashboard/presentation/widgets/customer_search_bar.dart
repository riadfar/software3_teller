import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class CustomerSearchBar extends StatelessWidget {
  final VoidCallback onTap;

  const CustomerSearchBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.navy.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.search_rounded, color: AppTheme.gold, size: 28),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Find Customer",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppTheme.navy,
                  ),
                ),
                Text(
                  "Search by ID, Account No, or Name",
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ),
            const Spacer(),
            // Container(
            //   padding: const EdgeInsets.all(8),
            //   decoration: BoxDecoration(
            //     color: AppTheme.platinum.withOpacity(0.5),
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: const Icon(Icons.qr_code_scanner_rounded, color: AppTheme.navy, size: 20),
            // ),
          ],
        ),
      ),
    );
  }
}