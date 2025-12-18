import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../customer_account/data/model/account.dart';
import '../../../customer_account/data/model/customer.dart';
import '../../../customer_account/presentation/screens/add_account_screen.dart';
import '../widgets/account_hierarchy_tile.dart';

// class CustomerProfileScreen extends StatelessWidget {
//   final Customer customer;
//   final List<Account> accounts;
//
//   const CustomerProfileScreen({
//     super.key,
//     required this.customer,
//     required this.accounts,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEFF3F6),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const PageHeader(title: "Customer Profile"),
//               const SizedBox(height: 30),
//
//               // Customer Info Card
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: AppTheme.navy,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 60,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         border: Border.all(color: AppTheme.gold, width: 2),
//                       ),
//                       child: Center(
//                         child: Text(
//                           customer.fullName[0],
//                           style: const TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: AppTheme.navy,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             customer.fullName,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             "National ID: ${customer.nationalId}",
//                             style: const TextStyle(
//                               color: Colors.white70,
//                               fontSize: 12,
//                             ),
//                           ),
//                           Text(
//                             customer.phone,
//                             style: const TextStyle(
//                               color: Colors.white70,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 30),
//
//               const Text(
//                 "Accounts Portfolio",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: AppTheme.navy,
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               ...accounts.map(
//                     (acc) => AccountHierarchyTile(account: acc),
//               ),
//
//               const SizedBox(height: 30),
//
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton.icon(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) =>
//                             AddAccountScreen(customer: customer),
//                       ),
//                     );
//                   },
//                   icon: const Icon(Icons.add_circle_outline),
//                   label: const Text("Open New Account"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: AppTheme.navy,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       side: const BorderSide(color: AppTheme.navy),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

