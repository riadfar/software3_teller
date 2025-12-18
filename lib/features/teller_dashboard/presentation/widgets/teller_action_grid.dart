import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../cash_deposit/data/api/deposit_api.dart';
import '../../../cash_deposit/data/repo/deposit_repo.dart';
import '../../../cash_deposit/logic/deposit/deposit_cubit.dart';
import '../../../cash_deposit/presentation/screens/cash_deposit_screen.dart';
import '../../../cash_withdrawal/data/api/withdrawal_api.dart';
import '../../../cash_withdrawal/data/repo/withdrawal_repo.dart';
import '../../../cash_withdrawal/logic/withdrawal/withdrawal_cubit.dart';
import '../../../cash_withdrawal/presentation/screens/cash_withdrawal_screen.dart';
import '../../../customer_account/data/api/customer_api.dart';
import '../../../customer_account/data/repo/customer_repo.dart';
import '../../../customer_account/presentation/screens/create_customer_screen.dart';
import '../../../settings/presentation/screens/settings_screen.dart';
import '../../../support_customer/presentation/screens/support_tickets_screen.dart';

class TellerActionGrid extends StatelessWidget {
  const TellerActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      // زدنا المسافة قليلاً ليظهر الظل بوضوح
      mainAxisSpacing: 20,
      childAspectRatio: 1.3,
      // نسبة العرض للطول
      children: [
        _buildActionCard(
          "Cash Deposit",
          Icons.input_rounded,
          Colors.green,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  child: CashDepositScreen(),
                  create: (create) => DepositCubit(
                    customerRepo: CustomerRepo(customerApi: CustomerApi()),
                    depositRepo: DepositRepo(depositApi: DepositApi()),
                  ),
                ),
              ),
            );
          },
        ),
        _buildActionCard(
          "Cash Withdrawal",
          Icons.output_rounded,
          Colors.redAccent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (context) => WithdrawalCubit(
                    customerRepo: CustomerRepo(customerApi: CustomerApi()),
                    withdrawalRepo: WithdrawalRepo(
                      withdrawalApi: WithdrawalApi(),
                    ),
                  ),
                  child: CashWithdrawalScreen(),
                ),
              ),
            );
          },
        ),
        _buildActionCard(
          "New Customer",
          Icons.person_add_alt_1_rounded,
          AppTheme.navy,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateCustomerScreen()),
            );
          },
        ),
        // _buildActionCard(
        //   "Customer Support",
        //   Icons.headset_mic_rounded, // أيقونة معبرة
        //   AppTheme.gold, // لون مميز
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (_) => const SupportTicketsScreen()),
        //     );
        //   },
        // ),
        _buildActionCard(
          "Settings",
          Icons.settings, // أيقونة معبرة
          AppTheme.greyText, // لون مميز
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionCard(
    String title,
    IconData icon,
    Color iconColor, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEFF3F6),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppTheme.navy.withOpacity(0.15),
              offset: const Offset(6, 6),
              blurRadius: 12,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-6, -6),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF3F6),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.navy.withOpacity(0.1),
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-2, -2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Icon(icon, size: 32, color: iconColor),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppTheme.navy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
