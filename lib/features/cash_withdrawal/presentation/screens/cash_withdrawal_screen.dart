import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/dialog_utils.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../customer_account/data/model/account.dart';
import '../../../search/data/models/mock_bank_data.dart';
import '../../logic/withdrawal/withdrawal_cubit.dart';
import '../widgets/withdrawal_account_section.dart';
import '../widgets/withdrawal_amount_section.dart';

class CashWithdrawalScreen extends StatefulWidget {
  const CashWithdrawalScreen({super.key});

  @override
  State<CashWithdrawalScreen> createState() => _CashWithdrawalScreenState();
}

class _CashWithdrawalScreenState extends State<CashWithdrawalScreen> {
  final _accountCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<WithdrawalCubit, WithdrawalState>(
      listener: (context, state) {
        if (state.status == WithdrawalStatus.loaded) {
          DialogUtils.showSuccess(
            context,
            title: "Success",
            content: "Cash withdrawn successfully.",
          );

          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context, rootNavigator: true).pop(); // close dialog
            Navigator.pop(context); // exit screen
          });
        }

        if (state.status == WithdrawalStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.messages.first),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF3F6),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PageHeader(title: "Cash Withdrawal"),
                const SizedBox(height: 30),

                BlocBuilder<WithdrawalCubit, WithdrawalState>(
                  builder: (context, state) {
                    final account = state.account;
                    final isLoading =
                        state.status == WithdrawalStatus.loading;

                    return Column(
                      children: [
                        WithdrawalAccountSection(
                          controller: _accountCtrl,
                          isVerifying: isLoading,
                          verifiedName: account?.customer.fullName,
                          currentBalance: account?.balance,
                          isFrozen: account?.isFrozen ?? false,
                          onVerify: () {
                            final acc = _accountCtrl.text.trim();
                            if (acc.isEmpty) return;

                            context
                                .read<WithdrawalCubit>()
                                .getCustomerAccount(accountNumber: acc);
                          },
                        ),

                        const SizedBox(height: 30),

                        if (account != null && !account.isFrozen) ...[
                          WithdrawalAmountSection(
                            controller: _amountCtrl,
                          ),
                          const SizedBox(height: 40),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () =>
                                  _handleWithdrawal(context, account),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                padding:
                                const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                                  : const Text(
                                "CONFIRM WITHDRAWAL",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],

                        if (account != null && account.isFrozen)
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.red),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.block, color: Colors.red),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    "This account is FROZEN.\nDeposits are currently restricted.",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleWithdrawal(BuildContext context, Account account) {
    if (_amountCtrl.text.isEmpty) return;

    final amount = double.tryParse(_amountCtrl.text);
    if (amount == null || amount <= 0) return;

    final currentBalance = double.parse(account.balance);

    // 🔴 شرطك المهم
    if (amount > currentBalance) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Insufficient balance. Available: \$${account.balance}",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return; // ⛔ لا Cubit
    }

    DialogUtils.showConfirmation(
      context,
      title: "Confirm Withdrawal?",
      content:
      "Withdraw \$$amount?\nBalance after: \$${(currentBalance - amount)
          .toStringAsFixed(2)}",
      confirmText: "WITHDRAW",
      confirmColor: Colors.redAccent,
      onConfirm: () {
        Navigator.pop(context);
        context.read<WithdrawalCubit>().withdrawal(amount: amount.toInt());
      },
    );
  }
}