import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class ReviewStep extends StatelessWidget {
  final String name;
  final String id;
  final String accountType;
  final String address; // جديد
  final String dob; // جديد
  // تم حذف amount و tempPassword لأنها تأتي من السيرفر بعد الإنشاء

  const ReviewStep({
    super.key,
    required this.name,
    required this.id,
    required this.accountType,
    required this.address,
    required this.dob,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.navy.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Review Information",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.navy,
            ),
          ),
          const Divider(height: 30),
          _buildRow("Customer Name", name),
          const SizedBox(height: 12),
          _buildRow("National ID", id),
          const SizedBox(height: 12),
          _buildRow("Date of Birth", dob), // جديد
          const SizedBox(height: 12),
          _buildRow("Address", address), // جديد
          const SizedBox(height: 12),
          _buildRow("Account Type", accountType),

          const Divider(height: 30),
          const Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: Colors.orange),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "By confirming, the account will be created and you will receive the Login Password.",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.navy,
            ),
          ),
        ),
      ],
    );
  }
}
