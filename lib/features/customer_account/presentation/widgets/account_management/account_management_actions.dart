import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/widgets/horizon_button.dart';

class AccountManagementActions extends StatelessWidget {
  final bool isFrozen;
  final bool isMainAccount;
  final bool canAddSubAccount;
  final VoidCallback onToggleFreeze;
  final VoidCallback onAddSubAccount;
  final VoidCallback onSave;
  final VoidCallback onResetPassword;
  final VoidCallback onCloseAccount;

  const AccountManagementActions({
    super.key,
    required this.isFrozen,
    required this.isMainAccount,
    required this.canAddSubAccount,
    required this.onToggleFreeze,
    required this.onAddSubAccount,
    required this.onSave,
    required this.onResetPassword,
    required this.onCloseAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. زر التجميد/فك التجميد
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(isFrozen ? "Unfreeze Account" : "Freeze Account", style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(isFrozen ? "Restore transactions" : "Block all outgoing funds", style: const TextStyle(fontSize: 12, color: Colors.grey)),
          trailing: Switch(
            value: isFrozen,
            activeColor: Colors.red,
            onChanged: (val) => onToggleFreeze(),
          ),
        ),
        const Divider(),

        // 2. زر إضافة حساب فرعي (يظهر فقط إذا لم يكن هذا حساباً فرعياً لفرعي)
        // (للتبسيط: نفترض أن الحسابات الرئيسية فقط تقبل فروع)
        if (canAddSubAccount) ...[
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("Create Sub-Account", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("Add a nested account under this one", style: TextStyle(fontSize: 12, color: Colors.grey)),
            trailing: IconButton(
              onPressed: onAddSubAccount,
              icon: const Icon(Icons.add_circle_outline, color: AppTheme.navy, size: 28),
            ),
          ),
          const Divider(),
        ],
        if (isMainAccount) ...[
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("Reset Customer Password", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("Generate a new temporary password", style: TextStyle(fontSize: 12, color: Colors.grey)),
            trailing: IconButton(
              onPressed: onResetPassword,
              icon: const Icon(Icons.vpn_key_rounded, color: Colors.orange, size: 28),
            ),
          ),
          const Divider(),
        ],
        const SizedBox(height: 10),

        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text("Close Account", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          subtitle: const Text("Permanently close and archive this account", style: TextStyle(fontSize: 12, color: Colors.redAccent)),
          trailing: IconButton(
            onPressed: onCloseAccount,
            icon: const Icon(Icons.delete_forever_rounded, color: Colors.red, size: 28),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}