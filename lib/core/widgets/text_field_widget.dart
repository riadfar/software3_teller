import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  final TextInputType inputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool readonly;
  final Function(String)? onChanged;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.controller,
    this.validator,
    this.onChanged,
    this.readonly = false,// 2. إضافته للـ Constructor
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: inputType,
      validator: validator,
      onChanged: onChanged,
      readOnly: readonly,
      style: const TextStyle(color: AppTheme.navy), // (تصحيح: const)
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: AppTheme.navy),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: readonly
          ? Colors.grey.withOpacity(0.15)
            : AppTheme.platinum.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.navy, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}