import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/text_field_widget.dart';

class WithdrawalAccountSection extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onVerify;
  final bool isVerifying;
  final String? verifiedName;
  final String? currentBalance;
  final bool isFrozen;

  const WithdrawalAccountSection({
    super.key,
    required this.controller,
    required this.onVerify,
    required this.isVerifying,
    this.verifiedName,
    this.currentBalance,
    this.isFrozen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                label: "Account Number",
                icon: Icons.account_balance_wallet_outlined,
                controller: controller,
              ),
            ),
            const SizedBox(width: 10),
            _buildVerifyButton(),
          ],
        ),

        if (verifiedName != null) _buildVerifiedCard(),
      ],
    );
  }

  Widget _buildVerifyButton() {
    return ElevatedButton(
      onPressed: isVerifying ? null : onVerify,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.navy,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: isVerifying
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : const Icon(Icons.search),
    );
  }

  Widget _buildVerifiedCard() {
    // الألوان: أحمر إذا مجمد، برتقالي إذا نشط (ليدل على السحب)
    final color = isFrozen ? Colors.red : Colors.orange.shade800;
    final icon = isFrozen ? Icons.lock : Icons.output_rounded;

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                verifiedName!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppTheme.navy,
                ),
              ),
              Text(
                "Balance: $currentBalance",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (isFrozen)
            const Text(
              "FROZEN",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
