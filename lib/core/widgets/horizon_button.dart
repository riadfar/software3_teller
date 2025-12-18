import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HorizonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final Color? color;

  const HorizonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    // 1. تغليف الزر بـ SizedBox ليأخذ العرض كاملاً
    return SizedBox(
      width: double.infinity, // <--- هذا هو السطر السحري
      child: isOutlined ? _buildOutlined() : _buildElevated(),
    );
  }

  // فصلنا الكود لترتيب الملف
  Widget _buildOutlined() {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildElevated() {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppTheme.navy,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        elevation: 5,
        shadowColor: (color ?? AppTheme.navy).withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}