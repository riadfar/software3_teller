import 'dart:math';

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/dialog_utils.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/horizon_button.dart';
import '../../../search/data/models/Account.dart';
import '../../../search/data/models/customer.dart';
import '../widgets/add_and_create/account_setup_step.dart';
import '../widgets/add_and_create/review_step.dart';
import '../widgets/add_and_create/step_indicator.dart';

// class AddAccountScreen extends StatefulWidget {
//   final Customer customer;
//
//   const AddAccountScreen({super.key, required this.customer});
//
//   @override
//   State<AddAccountScreen> createState() => _AddAccountScreenState();
// }
//
// class _AddAccountScreenState extends State<AddAccountScreen> {
//   int _currentStep = 0;
//   int _accountTypeIndex = 0;
//   final _depositCtrl = TextEditingController();
//   final _passwordCtrl = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEFF3F6),
//       body: SafeArea(
//         child: Column(
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(24.0),
//               child: PageHeader(title: "Open New Account"),
//             ),
//
//             // 1. المؤشر (خطوتين فقط)
//             StepIndicator(currentStep: _currentStep, totalSteps: 2),
//
//             // 2. المحتوى
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(24.0),
//                 child: _buildCurrentStepContent(),
//               ),
//             ),
//
//             // 3. الأزرار
//             _buildBottomBar(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _generateRandomPassword() {
//     const chars =
//         'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
//     Random rnd = Random();
//     String password = String.fromCharCodes(
//       Iterable.generate(8, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))),
//     );
//
//     setState(() {
//       _passwordCtrl.text = password;
//     });
//   }
//
//   Widget _buildCurrentStepContent() {
//     if (_currentStep == 0) {
//       return AccountSetupStep(
//         selectedTypeIndex: _accountTypeIndex,
//         onTypeSelected: (i) => setState(() => _accountTypeIndex = i),
//         depositCtrl: _depositCtrl,
//         passwordCtrl: _passwordCtrl,
//         onGeneratePassword: _generateRandomPassword,
//       );
//     } else {
//       return ReviewStep(
//         name: widget.customer.name, // البيانات موجودة مسبقاً
//         id: widget.customer.id,
//         accountType: _getAccountTypeName(),
//         amount: _depositCtrl.text,
//         tempPassword: _passwordCtrl.text,
//       );
//     }
//   }
//
//   Widget _buildBottomBar() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: const BoxDecoration(color: Colors.white),
//       child: Row(
//         children: [
//           if (_currentStep > 0) ...[
//             Expanded(
//               child: HorizonButton(
//                 text: "Back",
//                 onPressed: () => setState(() => _currentStep--),
//                 isOutlined: true,
//               ),
//             ),
//             const SizedBox(width: 16),
//           ],
//           Expanded(
//             flex: 2,
//             child: HorizonButton(
//               text: _currentStep == 1 ? "CONFIRM & OPEN" : "NEXT",
//               onPressed: _handleNext,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _handleNext() {
//     if (_currentStep == 0) {
//       if (_depositCtrl.text.isEmpty || _passwordCtrl.text.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text("Please enter deposit and generate password"),
//             backgroundColor: Colors.red));
//         return;
//       }
//     }
//     if (_currentStep == 0) {
//       setState(() => _currentStep++);
//     } else {
//       _finalizeCreation();
//     }
//   }
//
//   void _finalizeCreation() {
//     final newAccId = "ACC-${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}";
//     final newAccount = Account(
//         id: newAccId,
//         name: _getAccountTypeName(),
//         isSub: false,
//         balance: "\$${_depositCtrl.text}",
//     );
//
//     widget.customer.accounts.add(newAccount);
//
//     DialogUtils.showSuccess(
//         context,
//         title: "Account Opened",
//         content: "Successfully opened ${_getAccountTypeName()} for ${widget.customer.name}."
//     );
//   }
//
//   String _getAccountTypeName() => ["Savings Account", "Checking Account", "Business Account"][_accountTypeIndex];
// }