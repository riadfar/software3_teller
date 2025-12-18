import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/dialog_utils.dart';
import '../../../../core/widgets/page_header.dart';
import '../../logic/deposit/deposit_cubit.dart';
import '../widgets/deposit_account_section.dart';
import '../widgets/deposit_amount_section.dart';

class CashDepositScreen extends StatefulWidget {
  const CashDepositScreen({super.key});

  @override
  State<CashDepositScreen> createState() => _CashDepositScreenState();
}

class _CashDepositScreenState extends State<CashDepositScreen> {
  final _accountCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<DepositCubit, DepositState>(
        listener: (context, state) {
          if (state.status == DepositStatus.loaded) {
            Navigator.pop(context);
            DialogUtils.showSuccess(
              context,
              title: "Success",
              content: "Cash deposited successfully.",
            ).then((value) {

            },);
          }

          if (state.status == DepositStatus.error) {
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageHeader(title: "Cash Deposit"),
              const SizedBox(height: 30),

              BlocConsumer<DepositCubit, DepositState>(
                listener: (context, state) {
                  if (state.status == DepositStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error.messages.first),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }

                  if (state.status == DepositStatus.founded &&
                      state.account == null) {
                    DialogUtils.showSuccess(
                      context,
                      title: "Success",
                      content: "Cash deposited successfully.",
                    );

                    _accountCtrl.clear();
                    _amountCtrl.clear();
                  }
                },
                builder: (context, state) {
                  final account = state.account;
                  final isLoading = state.status == DepositStatus.loading;

                  return Column(
                    children: [
                      // 1️⃣ Account verification section
                      DepositAccountSection(
                        controller: _accountCtrl,
                        isVerifying: isLoading,
                        verifiedName: account?.customer.fullName,
                        currentBalance: account?.balance,
                        isFrozen: account?.isFrozen ?? false,
                        onVerify: () {
                          final input = _accountCtrl.text.trim();
                          if (input.isEmpty) return;

                          context.read<DepositCubit>().getCustomerAccount(
                            accountNumber: input,
                          );
                        },
                      ),

                      const SizedBox(height: 30),

                      // 2️⃣ Deposit amount section (only if active account)
                      if (account != null && !account.isFrozen) ...[
                        DepositAmountSection(controller: _amountCtrl),
                        const SizedBox(height: 40),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : () => _handleDeposit(context),

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 5,
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : const Text(
                              "CONFIRM DEPOSIT",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],

                      // 3️⃣ Frozen warning
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
  void _handleDeposit(BuildContext context) {
    if (_amountCtrl.text.isEmpty) return;

    final amount = int.tryParse(_amountCtrl.text);
    if (amount == null || amount <= 0) return;

    DialogUtils.showConfirmation(
      context,
      title: "Confirm Deposit?",
      content: "Deposit \$${amount} into this account?",
      confirmText: "DEPOSIT",
      confirmColor: Colors.green,
      onConfirm: () {
        Navigator.pop(context); // إغلاق Dialog
        context.read<DepositCubit>().deposit(amount: amount);
      },
    );
  }
}
