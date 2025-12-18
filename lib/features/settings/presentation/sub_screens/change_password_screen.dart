import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/dialog_utils.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/horizon_button.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../auth/logic/auth/auth_cubit.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPassCtrl = TextEditingController();
  final _newPassCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const PageHeader(title: "Change Password"),
              const SizedBox(height: 40),

              _buildPasswordField(
                "Old Password",
                _oldPassCtrl,
                _obscureOld,
                () => setState(() => _obscureOld = !_obscureOld),
              ),
              const SizedBox(height: 20),

              _buildPasswordField(
                "New Password",
                _newPassCtrl,
                _obscureNew,
                () => setState(() => _obscureNew = !_obscureNew),
              ),
              const SizedBox(height: 20),

              _buildPasswordField(
                "Confirm Password",
                _confirmPassCtrl,
                _obscureConfirm,
                () => setState(() => _obscureConfirm = !_obscureConfirm),
              ),

              const SizedBox(height: 40),

              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state.status == AuthStatus.loaded) {
                    DialogUtils.showSuccess(
                      context,
                      title: "Success",
                      content: "Your password has been updated successfully.",
                    );

                    Future.delayed(const Duration(seconds: 2), () {
                      if (mounted) {
                        Navigator.pop(context); // go back AFTER dialog
                      }
                    });
                  } else if (state.status == AuthStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Something went wrong"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Colors.redAccent,
                        duration: const Duration(seconds: 3),
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(16.0),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return state.status == AuthStatus.loading
                      ? LoadingWidget()
                      : HorizonButton(
                          text: "UPDATE PASSWORD",
                          onPressed: _handleUpdate,
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    String label,
    TextEditingController ctrl,
    bool isObscured,
    VoidCallback onToggle,
  ) {
    return CustomTextField(
      // أو HorizonTextField حسب تسميتك
      label: label,
      icon: Icons.lock_outline,
      controller: ctrl,
      isPassword: isObscured,
      suffixIcon: IconButton(
        icon: Icon(
          isObscured
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: Colors.grey,
        ),
        onPressed: onToggle,
      ),
    );
  }

  void _handleUpdate() {
    if (_oldPassCtrl.text.isEmpty ||
        _newPassCtrl.text.isEmpty ||
        _confirmPassCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_newPassCtrl.text != _confirmPassCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("New passwords do not match"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    BlocProvider.of<AuthCubit>(context).changePassword(
      oldPassword: _oldPassCtrl.text,
      newPassword: _newPassCtrl.text,
    );
  }
}
