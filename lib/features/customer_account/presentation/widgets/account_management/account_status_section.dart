import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class AccountStatusSection extends StatelessWidget {
  final String balance;
  final bool isFrozen;

  const AccountStatusSection({super.key, required this.balance, required this.isFrozen});

  @override
  Widget build(BuildContext context) {
    final color = isFrozen ? Colors.red : AppTheme.navy;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.account_balance, color: Colors.white70, size: 28),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                child: Text(isFrozen ? "FROZEN" : "ACTIVE", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text("Current Balance", style: TextStyle(color: Colors.white.withOpacity(0.7))),
          Text(balance, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Roboto Slab')),
        ],
      ),
    );
  }
}