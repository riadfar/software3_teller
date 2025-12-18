import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/page_header.dart';
import '../sub_screens/change_password_screen.dart';
import '../sub_screens/logout_dialog.dart';
import '../widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6), // نفس خلفية الـ Home
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageHeader(title: "Settings"),

              const SizedBox(height: 30),

              SettingsTile(
                title: "Change Password",
                icon: Icons.lock_reset_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen(),
                    ),
                  );
                }, // Open Change Password Dialog
              ),

              // 5. Logout Section
              SettingsTile(
                icon: Icons.logout_rounded,
                title: "Log Out",
                isDestructive: true, // يظهر باللون الأحمر
                onTap: () {
                  showLogoutDialog(context);
                  print("Logout Clicked");
                },
              ),

              const SizedBox(height: 20),

              // App Version
              Center(
                child: Text(
                  "Version 1.0.0 (Beta)",
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => LogoutDialog());
  }
}
