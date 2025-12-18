import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../customer_account/data/model/account.dart';
import '../../../customer_account/logic/customer_account/customer_account_cubit.dart';
import '../../../customer_account/presentation/screens/account_management_screen.dart';
import '../../data/models/customer.dart';
import '../../data/models/mock_bank_data.dart';
import 'customer_profile_screen.dart';

class CustomerSearchScreen extends StatefulWidget {
  const CustomerSearchScreen({super.key});

  @override
  State<CustomerSearchScreen> createState() => _CustomerSearchScreenState();
}

class _CustomerSearchScreenState extends State<CustomerSearchScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const PageHeader(title: "Find Customer"),
              const SizedBox(height: 20),

              CustomTextField(
                label: "Enter Account Number",
                icon: Icons.search,
                controller: _searchController,
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    context.read<CustomerAccountCubit>().getCustomerAccount(
                      accountNumber: val,
                    );
                  }
                },
              ),

              const SizedBox(height: 20),

              Expanded(
                child: BlocConsumer<CustomerAccountCubit, CustomerAccountState>(
                  listener: (context, state) {
                    if (state.status == CustomerAccountStatus.error) {
                      // نترك UI فاضي بدون Snackbar
                    }
                  },
                  builder: (context, state) {

                    if (state.status == CustomerAccountStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    print("UI STATUS: ${state.status}");
                    if (state.status == CustomerAccountStatus.loaded) {
                      return _buildAccountResultTile(state.account);
                    }

                    return _buildEmptyState();
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  // --- منطق البحث الحقيقي ---
  Widget _buildAccountResultTile(Account account) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: const CircleAvatar(
              backgroundColor: AppTheme.navy,
              child: Icon(Icons.account_balance, color: Colors.white),
            ),
            title: Text(
              account.customer.fullName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Acc: ${account.accountNumber} • ${account.balance}",
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AccountManagementScreen(account: account),
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  // ... (buildEmptyState كما هو)
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_search_rounded, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text("Search for a customer to begin", style: TextStyle(color: Colors.grey[400])),
        ],
      ),
    );
  }
}