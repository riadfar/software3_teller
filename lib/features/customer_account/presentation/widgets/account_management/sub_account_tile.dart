import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../data/model/sub_account.dart';

class SubAccountTile extends StatelessWidget {
  final SubAccount sub;

  const SubAccountTile({super.key, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.navy.withOpacity(0.05),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.subdirectory_arrow_right_rounded, color: AppTheme.navy),
        ),
        title: Text(sub.name, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.navy)),
        subtitle: Text("Balance: ${sub.balance}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () {
          // لاحقًا يمكنك فتح صفحة تفاصيل SubAccount
        },
      ),
    );
  }
}
