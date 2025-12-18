import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/widgets/text_field_widget.dart';


class EditAccountDialog extends StatefulWidget {
  final String currentName;
  final String currentType;
  final Function(String newName, String newType) onSave;

  const EditAccountDialog({
    super.key,
    required this.currentName,
    required this.currentType,
    required this.onSave,
  });

  @override
  State<EditAccountDialog> createState() => _EditAccountDialogState();
}

class _EditAccountDialogState extends State<EditAccountDialog> {
  late TextEditingController _nameCtrl;
  late String _selectedType;

  // أنواع الحسابات المتاحة
  final List<String> _accountTypes = [
    "Savings Account",
    "Checking Account",
    "Business Account",
    "Loan Account"
  ];

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.currentName);
    // التأكد من أن النوع الحالي موجود في القائمة، وإلا نختار الأول
    _selectedType = _accountTypes.contains(widget.currentType)
        ? widget.currentType
        : _accountTypes.first;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text("Edit Account Details", style: TextStyle(color: AppTheme.navy, fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. حقل الاسم
          CustomTextField(
            label: "Account Name",
            icon: Icons.edit_rounded,
            controller: _nameCtrl,
          ),
          const SizedBox(height: 20),

          // 2. القائمة المنسدلة للنوع
          const Text("Account Type", style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppTheme.platinum.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.transparent),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedType,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppTheme.navy),
                items: _accountTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type, style: const TextStyle(color: AppTheme.navy)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() => _selectedType = newValue);
                  }
                },
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: () {
            if (_nameCtrl.text.isNotEmpty) {
              widget.onSave(_nameCtrl.text, _selectedType);
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.navy,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text("Save Changes"),
        ),
      ],
    );
  }
}