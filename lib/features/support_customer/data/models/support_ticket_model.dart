import 'package:flutter/material.dart';

enum TicketStatus { open, pending, closed }

class SupportTicket {
  final String id;
  final String customerName;
  final String subject;
  final String lastMessage;
  final String time;
  final TicketStatus status;

  SupportTicket({
    required this.id,
    required this.customerName,
    required this.subject,
    required this.lastMessage,
    required this.time,
    required this.status,
  });

  // مساعد للألوان
  Color get statusColor {
    switch (status) {
      case TicketStatus.open: return Colors.green;
      case TicketStatus.pending: return Colors.orange;
      case TicketStatus.closed: return Colors.grey;
    }
  }
}