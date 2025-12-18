import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../request_details/presentation/screens/all_requests_screen.dart';
import '../../../request_details/presentation/widgets/request_tile.dart';
import '../../logic/request/request_cubit.dart';

class PendingRequestsList extends StatelessWidget {
  const PendingRequestsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestCubit, RequestState>(
      builder: (context, state) {
        if (state.status == RequestStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == RequestStatus.error) {
          return Center(child: Text("Error: ${state.error}"));
        }

        final requests = state.requests;

        if (requests.isEmpty) {
          return const Center(
            child: Text("No pending requests", style: TextStyle(color: Colors.grey)),
          );
        }

        // أخذ أول عنصرين فقط
        final pending = requests.take(2).toList();

        return Column(
          children: [
            // 1. Header with See All
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "Pending Tasks",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.navy),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
                      child: Text("${requests.length}", style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),

                // زر See All
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AllRequestsScreen()),
                    );
                  },
                  child: const Text("See All", style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 2. الطلبات
            ...pending.map((req) => RequestTile(
              request: req,
              onAccept: () => context.read<RequestCubit>().acceptRequest(req.id),
              onReject: (reason) => context.read<RequestCubit>().rejectRequest(req.id, reason),
            )),

          ],
        );
      },
    );
  }
}
