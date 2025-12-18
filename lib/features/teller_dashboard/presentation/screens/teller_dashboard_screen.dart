import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../search/presentation/screens/customer_search_screen.dart';
import '../../data/api/request_api.dart';
import '../../data/repo/request_repo.dart';
import '../../logic/request/request_cubit.dart';
import '../widgets/teller_header.dart';
import '../widgets/customer_search_bar.dart';
import '../widgets/pending_requests_list.dart';
import '../widgets/teller_action_grid.dart';

class TellerDashboardScreen extends StatelessWidget {
  final String tellerName;

  const TellerDashboardScreen({super.key, required this.tellerName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RequestCubit(repo: RequestRepo(requestApi: RequestApi()))
            ..fetchAllRequests(),
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF3F6),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header
                TellerHeader(tellerName: tellerName),
                const SizedBox(height: 30),

                // 2. Search
                CustomerSearchBar(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomerSearchScreen(),
                      ),
                    );
                    print("Search Tapped");
                  },
                ),
                const SizedBox(height: 30),

                // 3. Pending Tasks (Chain of Responsibility)
                const PendingRequestsList(),
                const SizedBox(height: 30),

                // 4. Quick Actions
                const TellerActionGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
