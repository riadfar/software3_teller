import 'package:flutter/material.dart';
import '../../../../../core/widgets/text_field_widget.dart';

import 'package:flutter/material.dart';
import '../../../../../core/widgets/text_field_widget.dart'; // تأكد من المسار

class PersonalInfoStep extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController idCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController emailCtrl;
  // حقول جديدة
  final TextEditingController addressCtrl;
  final TextEditingController dobCtrl;
  final VoidCallback onTapDob; // لفتح مختار التاريخ

  const PersonalInfoStep({
    super.key,
    required this.nameCtrl,
    required this.idCtrl,
    required this.phoneCtrl,
    required this.emailCtrl,
    required this.addressCtrl,
    required this.dobCtrl,
    required this.onTapDob,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Customer Details",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        CustomTextField(
          label: "Full Name",
          icon: Icons.person_outline,
          controller: nameCtrl,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: "National ID / Passport",
          icon: Icons.badge_outlined,
          controller: idCtrl,
        ),
        const SizedBox(height: 16),
        // حقل تاريخ الميلاد
        GestureDetector(
          onTap: onTapDob,
          child: AbsorbPointer(
            child: CustomTextField(
              label: "Date of Birth (YYYY-MM-DD)",
              icon: Icons.calendar_today_outlined,
              controller: dobCtrl,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // حقل العنوان
        CustomTextField(
          label: "Address",
          icon: Icons.location_on_outlined,
          controller: addressCtrl,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: "Phone Number",
          icon: Icons.phone_outlined,
          controller: phoneCtrl,
          inputType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: "Email Address",
          icon: Icons.email_outlined,
          controller: emailCtrl,
          inputType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}
