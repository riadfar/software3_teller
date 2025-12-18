import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class AccountSettingsForm extends StatelessWidget {
  final String accountName;
  final String accountType;
  final VoidCallback onEditTap; // زر التعديل

  const AccountSettingsForm({
    super.key,
    required this.accountName,
    required this.accountType,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الهيدر مع زر التعديل
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Account Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.navy)),
            IconButton(
              onPressed: onEditTap,
              icon: const Icon(Icons.edit_note_rounded, color: AppTheme.gold, size: 28),
              tooltip: "Edit Details",
            ),
          ],
        ),
        const SizedBox(height: 10),

        // عرض البيانات بستايل نظيف
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            children: [
              _buildDetailRow(Icons.label_outline_rounded, "Alias", accountName),
              const Divider(height: 24),
              _buildDetailRow(Icons.category_outlined, "Type", accountType),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.navy.withOpacity(0.05),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppTheme.navy, size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.navy)),
          ],
        ),
      ],
    );
  }
}