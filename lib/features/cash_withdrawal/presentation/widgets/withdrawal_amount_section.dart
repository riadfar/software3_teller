import 'package:flutter/material.dart';
import '../../../../core/widgets/text_field_widget.dart';

class WithdrawalAmountSection extends StatelessWidget {
  final TextEditingController controller;

  const WithdrawalAmountSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Withdrawal Details",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        CustomTextField(
          label: "Amount to Withdraw",
          icon: Icons.money_off_rounded,
          controller: controller,
          inputType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 8),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Destination: Cash to Customer",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
