import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../teller_dashboard/presentation/screens/teller_dashboard_screen.dart';
import '../../logic/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- 1. Header Section ---
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .45,
              decoration: const BoxDecoration(
                color: AppTheme.navy,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    height: MediaQuery.of(context).size.height * .29,
                    'assets/images/mian_logo.png',
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Future of Banking",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * .05),

            // --- 2. Form Section ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: AppTheme.navy,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    CustomTextField(
                      label: "User Name",
                      icon: Icons.account_balance_wallet_outlined,
                      inputType: TextInputType.name,
                      controller: _accountController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter account number';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    CustomTextField(
                      label: "Password",
                      icon: Icons.lock_outline,
                      isPassword: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Password is too short';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state.status == AuthStatus.loaded) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TellerDashboardScreen(
                                tellerName: _accountController.text,
                              ),
                            ),
                          );
                        } else if (state.status == AuthStatus.error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("invalid Email Or Password"),
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
                            : ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    print(
                                      "Account: ${_accountController.text}",
                                    );
                                    print(
                                      "Password: ${_passwordController.text}",
                                    );
                                    BlocProvider.of<AuthCubit>(context).login(
                                      userName: _accountController.text,
                                      password: _passwordController.text,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.gold,
                                  foregroundColor: AppTheme.navy,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
                                ),
                                child: const Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
