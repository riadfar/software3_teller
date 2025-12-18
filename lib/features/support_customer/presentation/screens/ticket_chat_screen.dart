import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/dialog_utils.dart';
import '../../../../core/widgets/page_header.dart';
import '../../data/models/support_ticket_model.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_area.dart';

class TicketChatScreen extends StatefulWidget {
  // نقبل التذكرة كبارامتر لعرض بياناتها
  final SupportTicket ticket;

  const TicketChatScreen({super.key, required this.ticket});

  @override
  State<TicketChatScreen> createState() => _TicketChatScreenState();
}

class _TicketChatScreenState extends State<TicketChatScreen> {
  final _msgController = TextEditingController();

  // رسائل وهمية للمحاكاة
  final List<Map<String, dynamic>> _messages = [
    {"msg": "Hello, I tried to transfer \$500 but it failed.", "time": "10:30 AM", "isMe": false},
    {"msg": "Hi Samer, I can check that for you. What was the error?", "time": "10:32 AM", "isMe": true},
    {"msg": "It said 'Insufficient Funds' but I have money.", "time": "10:33 AM", "isMe": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Custom Header with Action
            _buildChatHeader(context),

            // 2. Chat List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final m = _messages[index];
                  return ChatBubble(
                    message: m['msg'],
                    time: m['time'],
                    isMe: m['isMe'],
                  );
                },
              ),
            ),

            // 3. Input Area
            ChatInputArea(
              controller: _msgController,
              onSend: _handleSend,
            ),
          ],
        ),
      ),
    );
  }

  // هيدر مخصص لهذه الشاشة ليحتوي على زر الإغلاق
  Widget _buildChatHeader(BuildContext context) {
    return Container(
      color: const Color(0xFFEFF3F6),
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // زر الرجوع والعنوان
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(12),
                child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.navy, size: 20),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.ticket.customerName,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.navy),
                  ),
                  Text(
                    "Ticket #${widget.ticket.id}",
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ],
          ),

          // زر حل المشكلة (Resolve)
          if (widget.ticket.status != TicketStatus.closed)
            ElevatedButton(
              onPressed: _resolveTicket,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Resolve", style: TextStyle(fontSize: 12)),
            ),
        ],
      ),
    );
  }

  void _handleSend() {
    if (_msgController.text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        "msg": _msgController.text,
        "time": "Now",
        "isMe": true, // رسالة الصراف
      });
      _msgController.clear();
    });
  }

  void _resolveTicket() {
    DialogUtils.showConfirmation(
      context,
      title: "Close Ticket?",
      content: "Mark this issue as resolved and archive the ticket?",
      confirmText: "Resolve & Close",
      confirmColor: Colors.green,
      onConfirm: () {
        Navigator.pop(context); // Close Dialog
        Navigator.pop(context); // Back to List
        // يمكن إضافة منطق تحديث الحالة في الباك إند هنا
      },
    );
  }
}