import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/support_ticket_model.dart';

class SupportTicketTile extends StatelessWidget {
  final SupportTicket ticket;
  final VoidCallback onTap;

  const SupportTicketTile({
    super.key,
    required this.ticket,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Status Indicator
            Container(
              width: 4,
              height: 50,
              decoration: BoxDecoration(
                color: ticket.statusColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ticket.customerName,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.navy),
                      ),
                      Text(
                        ticket.time,
                        style: TextStyle(fontSize: 11, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ticket.subject,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ticket.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),
            Icon(Icons.chevron_right_rounded, color: Colors.grey[300]),
          ],
        ),
      ),
    );
  }
}