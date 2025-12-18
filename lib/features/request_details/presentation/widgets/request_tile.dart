import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../teller_dashboard/data/model/request.dart';


class RequestTile extends StatelessWidget {
  final Request request;
  final VoidCallback onAccept;
  final Function(String reason) onReject;

  const RequestTile({
    super.key,
    required this.request,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showRequestDialog(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.ac_unit, color: Colors.orange, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(request.requestType,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: AppTheme.navy)),
                  const SizedBox(height: 4),
                  Text("${request.bankAccount.customer.fullName} - ${request.bankAccount.accountNumber}",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  const SizedBox(height: 4),
                  Text("Status: ${request.requestStatus}",
                      style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showRequestDialog(BuildContext context) {
    final rejectController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(request.requestType,
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.navy)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Customer: ${request.bankAccount.customer.fullName}"),
                const SizedBox(height: 4),
                Text("Account: ${request.bankAccount.accountNumber}"),
                const SizedBox(height: 4),
                Text("Current Balance: \$${request.bankAccount.balance}"),
                const SizedBox(height: 4),
                Text("Request Reason: ${request.reason}"),
                const SizedBox(height: 12),
                Text("Take Action:", style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onAccept();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: const Text("Accept"),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _showRejectReasonDialog(context, rejectController);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: const Text("Reject"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRejectReasonDialog(BuildContext context, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Reject Request", style: TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: controller,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: "Enter reason for rejection",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isEmpty) return;
                Navigator.pop(context);
                onReject(controller.text.trim());
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white),
              child: const Text("Reject"),
            ),
          ],
        );
      },
    );
  }
}


