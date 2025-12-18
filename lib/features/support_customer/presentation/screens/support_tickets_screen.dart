import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/page_header.dart';
import '../../data/models/support_ticket_model.dart';
import '../screens/ticket_chat_screen.dart';
import '../widgets/support_ticket_tile.dart';

class SupportTicketsScreen extends StatefulWidget {
  const SupportTicketsScreen({super.key});

  @override
  State<SupportTicketsScreen> createState() => _SupportTicketsScreenState();
}

class _SupportTicketsScreenState extends State<SupportTicketsScreen> {
 int _selectedFilterIndex = 0;

  // Mock Data
  final List<SupportTicket> _allTickets = [
    SupportTicket(
      id: "T-101",
      customerName: "Samer Jaber",
      subject: "Transfer Failed",
      lastMessage: "I tried to send money but it got stuck...",
      time: "10m ago",
      status: TicketStatus.open,
    ),
    SupportTicket(
      id: "T-102",
      customerName: "Tech Vision Ltd",
      subject: "Limit Increase",
      lastMessage: "We need to increase our daily limit to 200k.",
      time: "2h ago",
      status: TicketStatus.pending,
    ),
    SupportTicket(
      id: "T-103",
      customerName: "Ahmad Al-Saeed",
      subject: "Card Lost",
      lastMessage: "Resolved: Card blocked and re-issued.",
      time: "1d ago",
      status: TicketStatus.closed,
    ),
    SupportTicket(
      id: "T-104",
      customerName: "Lara M.",
      subject: "Login Issue",
      lastMessage: "Cannot access my account via web.",
      time: "3h ago",
      status: TicketStatus.open,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // 2. تصفية القائمة بناءً على الاختيار
    final filteredTickets = _getFilteredList();

    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: PageHeader(title: "Customer Support"),
            ),

            // Tabs / Filters
            _buildFilterTabs(),

            const SizedBox(height: 20),

            // List
            Expanded(
              child: filteredTickets.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: filteredTickets.length,
                itemBuilder: (context, index) {
                  return SupportTicketTile(
                    ticket: filteredTickets[index],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TicketChatScreen(ticket: filteredTickets[index])
                          )
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

  // دالة المنطق لتصفية القائمة
  List<SupportTicket> _getFilteredList() {
    switch (_selectedFilterIndex) {
      case 1: // Open
        return _allTickets.where((t) => t.status == TicketStatus.open).toList();
      case 2: // Pending
        return _allTickets.where((t) => t.status == TicketStatus.pending).toList();
      case 3: // Closed
        return _allTickets.where((t) => t.status == TicketStatus.closed).toList();
      default: // All (Index 0)
        return _allTickets;
    }
  }

  Widget _buildFilterTabs() {
    final filters = ["All Tickets", "Open", "Pending", "Closed"];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = _selectedFilterIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilterIndex = index; // تحديث الحالة عند الضغط
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.navy : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: isSelected ? null : Border.all(color: Colors.grey.shade300),
                boxShadow: isSelected
                    ? [BoxShadow(color: AppTheme.navy.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))]
                    : [],
              ),
              child: Center(
                child: Text(
                  filters[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 60, color: Colors.grey[300]),
          const SizedBox(height: 10),
          Text("No tickets found", style: TextStyle(color: Colors.grey[400])),
        ],
      ),
    );
  }
}