import 'package:flutter/material.dart';
import '../../../../core/widgets/text_field_widget.dart';

class DepositAmountSection extends StatelessWidget {
  final TextEditingController controller;

  const DepositAmountSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Deposit Details",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        CustomTextField(
          label: "Cash Amount",
          icon: Icons.attach_money_rounded,
          controller: controller,
          inputType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 8),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Source: Cash Counter",
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
