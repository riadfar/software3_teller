import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/widgets/text_field_widget.dart';

class PasswordResetDialog extends StatefulWidget {
  final Function(String) onConfirm;

  const PasswordResetDialog({super.key, required this.onConfirm});

  @override
  State<PasswordResetDialog> createState() => _PasswordResetDialogState();
}

class _PasswordResetDialogState extends State<PasswordResetDialog> {
  final _passCtrl = TextEditingController();

  void _generatePassword() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    Random rnd = Random();
    String pass = String.fromCharCodes(Iterable.generate(8, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
    setState(() => _passCtrl.text = pass);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text("Reset Password", style: TextStyle(color: AppTheme.navy, fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Generate a new temporary password for the customer.", style: TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: "New Password",
                  icon: Icons.lock,
                  controller: _passCtrl,
                  readonly: true, // للقراءة فقط
                ),
              ),
              const SizedBox(width: 10),
              IconButton.filled(
                onPressed: _generatePassword,
                style: IconButton.styleFrom(backgroundColor: AppTheme.navy),
                icon: const Icon(Icons.refresh, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            if (_passCtrl.text.isNotEmpty) {
              widget.onConfirm(_passCtrl.text);
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
          child: const Text("Update Password"),
        ),
      ],
    );
  }
}