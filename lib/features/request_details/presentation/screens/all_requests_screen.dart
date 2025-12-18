import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../teller_dashboard/logic/request/request_cubit.dart';
import '../widgets/request_tile.dart';

class AllRequestsScreen extends StatelessWidget {
  const AllRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // تحميل الطلبات عند فتح الشاشة
    context.read<RequestCubit>().fetchAllRequests();

    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: PageHeader(title: "All Pending Tasks"),
            ),

            // القائمة الكاملة
            Expanded(
              child: BlocBuilder<RequestCubit, RequestState>(
                builder: (context, state) {
                  if (state.status == RequestStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.status == RequestStatus.error) {
                    return Center(
                      child: Text(
                        state.error ?? "Failed to load requests",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final requests = state.requests;

                  if (requests.isEmpty) {
                    return const Center(
                      child: Text(
                        "No pending requests",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      final req = requests[index];
                      return RequestTile(
                        request: req,
                        onAccept: () => context.read<RequestCubit>().acceptRequest(req.id),
                        onReject: (reason) => context.read<RequestCubit>().rejectRequest(req.id, reason),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
