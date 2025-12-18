import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/horizon_button.dart';
import '../../../../core/widgets/dialog_utils.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../data/model/account.dart';

class CreateSubAccountScreen extends StatefulWidget {
  final Account parentAccount; // الحساب الأب الذي سنضيف تحته

  const CreateSubAccountScreen({super.key, required this.parentAccount});

  @override
  State<CreateSubAccountScreen> createState() => _CreateSubAccountScreenState();
}

class _CreateSubAccountScreenState extends State<CreateSubAccountScreen> {
  final _nameCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  String _selectedType = "Savings"; // النوع الافتراضي

  final List<String> _subTypes = ["Savings", "Education", "Emergency", "Travel"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageHeader(title: "New Sub-Account"),
              const SizedBox(height: 20),

              // 1. بطاقة الحساب الأب (للسياق)
              _buildParentContextCard(),
              const SizedBox(height: 30),

              // 2. نموذج البيانات
              const Text("Sub-Account Details", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.navy)),
              const SizedBox(height: 16),

              CustomTextField(
                  label: "Sub-Account Name (Alias)",
                  icon: Icons.label_outline,
                  controller: _nameCtrl
              ),
              const SizedBox(height: 16),

              // اختيار النوع (Chips)
              const Text("Purpose / Type", style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                children: _subTypes.map((type) => _buildTypeChip(type)).toList(),
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: "Initial Deposit",
                icon: Icons.attach_money,
                controller: _amountCtrl,
                inputType: const TextInputType.numberWithOptions(decimal: true),
              ),

              const SizedBox(height: 40),

              
              HorizonButton(
                text: "CREATE SUB-ACCOUNT",
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParentContextCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.navy.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.navy.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.subdirectory_arrow_right_rounded, color: AppTheme.navy),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Linking to Parent Account:", style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text(widget.parentAccount.accountNumber, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.navy)),
              Text(widget.parentAccount.accountType.name, style: const TextStyle(fontSize: 12, color: AppTheme.navy)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeChip(String label) {
    final isSelected = _selectedType == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) => setState(() => _selectedType = label),
      selectedColor: AppTheme.navy,
      labelStyle: TextStyle(color: isSelected ? Colors.white : AppTheme.navy),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: isSelected ? Colors.transparent : Colors.grey.shade300)),
    );
  }


}