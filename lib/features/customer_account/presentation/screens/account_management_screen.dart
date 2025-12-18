import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/dialog_utils.dart';
import '../../../../core/widgets/page_header.dart';

import '../../../search/presentation/widgets/account_hierarchy_tile.dart';
import '../../data/model/account.dart';
import '../widgets/account_management/account_status_section.dart';
import '../widgets/account_management/account_settings_form.dart';
import '../widgets/account_management/account_management_actions.dart';
import '../widgets/account_management/edit_account_dialog.dart';
import '../widgets/account_management/password_reset_dialog.dart';
import '../widgets/account_management/sub_account_tile.dart';
import 'create_sub_account_screen.dart';

class AccountManagementScreen extends StatefulWidget {
  final Account account;

  const AccountManagementScreen({super.key, required this.account});

  @override
  State<AccountManagementScreen> createState() =>
      _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  late bool _isFrozen;
  late String _currentName; // لحفظ التغيير محلياً
  late String _currentType; // لحفظ التغيير محلياً

  @override
  void initState() {
    super.initState();
    _isFrozen = widget.account.isFrozen;
    _currentName = widget.account.accountNumber; // Display only (اسم وهمي للعرض)
    _currentType = widget.account.accountType == AccountType.savings ? "Savings" : "Other";
  }

  @override
  Widget build(BuildContext context) {
    final bool canHaveChildren = true; // قرار Backend

    final bool hasSubAccountsToDisplay =
        widget.account.subAccounts.isNotEmpty;


    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageHeader(title: "Manage Account"),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.navy,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Text(
                        widget.account.customer.fullName[0],
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.navy,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.account.customer.fullName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "National ID: ${widget.account.customer.nationalId}",
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          Text(
                            widget.account.customer.phone,
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 1. Status Header
              AccountStatusSection(
                balance: widget.account.balance,
                isFrozen: _isFrozen,
              ),
              const SizedBox(height: 30),
              // 2. Settings Display (Read-Only with Edit Button)
              AccountSettingsForm(
                accountName: _currentName,
                accountType: _currentType,
                onEditTap: _openEditDialog, // فتح الديالوج
              ),
              // 4. Sub-Accounts
              if (hasSubAccountsToDisplay) ...[
                const SizedBox(height: 30),
                const Text(
                  "Sub-Accounts",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.navy,
                  ),
                ),
                const SizedBox(height: 10),
                // الآن يمكننا استخدام ! بأمان لأننا تحققنا من null في المتغير hasSubAccountsToDisplay
                ...widget.account.subAccounts.map(
                      (sub) => SubAccountTile(sub: sub),
                ),
              ],


              const SizedBox(height: 20),

              // 3. Actions
              AccountManagementActions(
                isFrozen: _isFrozen,
                isMainAccount: true,
                canAddSubAccount: canHaveChildren,
                onToggleFreeze: _toggleFreeze,
                onAddSubAccount: _addSubAccount,
                onSave: _saveChanges,
                onResetPassword: _openResetPasswordDialog,
                onCloseAccount: _handleCloseAccount,
              ),

            ],
          ),
        ),
      ),
    );
  }


  void _openResetPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => PasswordResetDialog(
        onConfirm: (newPass) {
          // هنا يتم استدعاء API تغيير كلمة المرور
          DialogUtils.showSuccess(
              context,
              title: "Password Updated",
              content: "Temporary password is: $newPass\nPlease share it with the customer."
          );
        },
      ),
    );
  }


  void _handleCloseAccount() {
    DialogUtils.showConfirmation(
      context,
      title: "Close Account?",
      content: "Are you sure you want to permanently close ${widget.account.accountNumber}?\nThis action cannot be undone.",
      confirmText: "CLOSE ACCOUNT",
      confirmColor: Colors.red,
      onConfirm: () {
        Navigator.pop(context); // إغلاق الديالوج

        // محاكاة الحذف (في الواقع Backend API)
        // يجب العودة للشاشة السابقة لأن هذا الحساب لم يعد موجوداً
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account Closed Successfully"), backgroundColor: Colors.red),
        );
      },
    );
  }

  void _openEditDialog() {
    showDialog(
      context: context,
      builder: (context) => EditAccountDialog(
        currentName: _currentName,
        currentType: _currentType,
        onSave: (newName, newType) {
          setState(() {
            _currentName = newName;
            _currentType = newType;
          });
          Navigator.of(context).pop();
          _saveChanges();
          DialogUtils.showSuccess(
            context,
            title: "Updated",
            content: "Account details updated successfully.",
          );
        },
      ),
    );
  }

  void _toggleFreeze() {
    setState(() => _isFrozen = !_isFrozen);
    final msg = _isFrozen ? "Account Frozen" : "Account Activated";
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: _isFrozen ? Colors.red : Colors.green,
      ),
    );
  }

  void _addSubAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateSubAccountScreen(parentAccount: widget.account),
      ),
    );
  }

  void _saveChanges() {
    // حفظ الاسم الجديد في الداتا الوهمية (أو API)
    // widget.account.name = _nameCtrl.text; // (يحتاج أن يكون المتغير غير final في المودل)
    DialogUtils.showSuccess(
      context,
      title: "Saved",
      content: "Account details updated successfully.",
    );
  }
}
