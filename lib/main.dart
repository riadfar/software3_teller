import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/data/api/auth_api.dart';
import 'features/auth/data/repo/auth_repo.dart';
import 'features/auth/logic/auth/auth_cubit.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/customer_account/data/api/customer_api.dart';
import 'features/customer_account/data/repo/customer_repo.dart';
import 'features/customer_account/logic/customer_account/customer_account_cubit.dart';
import 'features/teller_dashboard/data/api/request_api.dart';
import 'features/teller_dashboard/data/repo/request_repo.dart';
import 'features/teller_dashboard/logic/request/request_cubit.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (create) => AuthCubit(authRepo: AuthRepo(authApi: AuthApi())),
        ),
        BlocProvider(
          create: (create) => CustomerAccountCubit(
            customerRepo: CustomerRepo(customerApi: CustomerApi()),
          ),
        ),
        BlocProvider(
          create: (create) =>
              RequestCubit(repo: RequestRepo(requestApi: RequestApi())),
        ),
      ],
      child: MaterialApp(title: 'Horizon Bank Emp', home: SplashScreen()),
    );
  }
}
