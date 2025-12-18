import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../customer_account/data/model/account.dart';
import '../../../customer_account/data/model/sub_account.dart';
import '../../../customer_account/presentation/screens/account_management_screen.dart';

class AccountHierarchyTile extends StatefulWidget {
  final Account account;

  const AccountHierarchyTile({super.key, required this.account});

  @override
  State<AccountHierarchyTile> createState() => _AccountHierarchyTileState();
}

class _AccountHierarchyTileState extends State<AccountHierarchyTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasChildren = widget.account.subAccounts.isNotEmpty;
    final isFrozen = widget.account.isFrozen;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          // 1. جسم الحساب (للانتقال إلى صفحة الإدارة)
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AccountManagementScreen(account: widget.account)),
              );
            },
            leading: _buildIcon(isFrozen),
            title: Text(
              widget.account.accountType.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.navy,
              ),
            ),
            subtitle: Text(
              widget.account.accountNumber,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.account.balance, style: TextStyle(fontWeight: FontWeight.bold, color: isFrozen ? Colors.red : AppTheme.gold)),
                const SizedBox(width: 8),
                // زر التوسيع (يظهر فقط إذا كان هناك أبناء)
                if (hasChildren)
                  IconButton(
                    icon: Icon(_isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, color: Colors.grey),
                    onPressed: () => setState(() => _isExpanded = !_isExpanded),
                  ),
                if (!hasChildren) const SizedBox(width: 48), // حفظ مسافة للتناسق
              ],
            ),
          ),

          // 2. قائمة الأبناء (تظهر عند التوسيع)
          if (hasChildren)
            AnimatedCrossFade(
              firstChild: Container(),
              secondChild: Column(
                children: widget.account.subAccounts!.map((sub) => _buildSubAccountItem(sub)).toList(),
              ),
              crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
        ],
      ),
    );
  }

  Widget _buildIcon(bool isFrozen) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isFrozen ? Colors.red.withOpacity(0.1) : AppTheme.navy.withOpacity(0.05),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isFrozen ? Icons.lock_outline : Icons.account_balance_wallet_outlined,
        color: isFrozen ? Colors.red : AppTheme.navy,
      ),
    );
  }

  Widget _buildSubAccountItem(SubAccount sub) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade100)),
        color: Colors.grey.shade50,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 32, right: 16),
        leading: const Icon(
          Icons.subdirectory_arrow_right_rounded,
          color: Colors.grey,
          size: 20,
        ),
        title: Text(
          sub.name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: const Text(
          "Sub Account",
          style: TextStyle(fontSize: 12),
        ),
        trailing: Text(
          sub.balance,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        onTap: () {
          // 👈 لاحقًا إذا بدك صفحة خاصة بالـ sub account
        },
      ),
    );
  }

}