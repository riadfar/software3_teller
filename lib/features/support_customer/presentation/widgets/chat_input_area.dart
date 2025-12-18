import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ChatInputArea extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputArea({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          // زر المرفقات (اختياري)
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.attach_file_rounded, color: Colors.grey[400]),
          ),
          // حقل الكتابة
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF3F6),
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Type your reply...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // زر الإرسال
          GestureDetector(
            onTap: onSend,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppTheme.navy,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}