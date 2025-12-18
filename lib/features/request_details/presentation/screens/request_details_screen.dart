import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/dialog_utils.dart';
import '../../../../core/widgets/page_header.dart';
import '../widgets/request_info_card.dart';

class RequestDetailsScreen extends StatelessWidget {
  // يمكن تمرير مودل كامل هنا لاحقاً
  final String title;

  const RequestDetailsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageHeader(title: "Request Details"),
              const SizedBox(height: 30),

              // 1. بطاقة التفاصيل
              RequestInfoCard(
                requestType: title,
                customerName: "Ahmad Al-Saeed",
                accountNo: "PREM-8829-102",
                requestDate: "Today, 10:45 AM",
                reason: "Suspicious activity detected by user.",
              ),

              const Spacer(),

              // 2. أزرار القرار (Decision Buttons)
              Row(
                children: [
                  // زر الرفض
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _handleReject(context),
                      icon: const Icon(Icons.close_rounded),
                      label: const Text("Reject"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // زر الموافقة
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _handleApprove(context),
                      icon: const Icon(Icons.check_rounded),
                      label: const Text("Approve"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.navy,
                        foregroundColor: Colors.white,
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleApprove(BuildContext context) {
    DialogUtils.showConfirmation(
      context,
      title: "Approve Request?",
      content: "This action will execute the request immediately.",
      confirmText: "Approve",
      confirmColor: Colors.green,
      onConfirm: () {
        Navigator.pop(context);
        Navigator.pop(context);


        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Request Approved Successfully"),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }

  void _handleReject(BuildContext context) {
    DialogUtils.showConfirmation(
      context,
      title: "Reject Request?",
      content: "The customer will be notified of the rejection.",
      confirmText: "Reject",
      confirmColor: Colors.red,
      onConfirm: () {
        Navigator.pop(context);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Request Rejected"),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }
}