import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/widgets/text_field_widget.dart';

import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart'; // تأكد من المسار

class AccountSetupStep extends StatelessWidget {
  final int selectedTypeIndex;
  final Function(int) onTypeSelected;
  // تم حذف الحقول الغير مستخدمة (Deposit & Password)

  const AccountSetupStep({
    super.key,
    required this.selectedTypeIndex,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Account Type",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        // Account Type Selector
        _buildTypeCard(0, "Savings Account", Icons.savings_outlined),
        const SizedBox(height: 12),
        _buildTypeCard(1, "Checking Account", Icons.payments_outlined),
        const SizedBox(height: 12),
        _buildTypeCard(2, "Business Account", Icons.business_center_outlined),
      ],
    );
  }

  Widget _buildTypeCard(int index, String title, IconData icon) {
    final isSelected = selectedTypeIndex == index;
    return GestureDetector(
      onTap: () => onTypeSelected(index),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.navy.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.navy : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppTheme.navy : Colors.grey),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? AppTheme.navy : Colors.grey.shade700,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppTheme.navy),
          ],
        ),
      ),
    );
  }
}
