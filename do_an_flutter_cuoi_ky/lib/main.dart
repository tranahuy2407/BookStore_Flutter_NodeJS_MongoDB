import 'package:do_an_flutter_cuoi_ky/common/widgets/bottom_bar.dart';
import 'package:do_an_flutter_cuoi_ky/constants/global_variables.dart';
import 'package:do_an_flutter_cuoi_ky/features/auth/screens/auth_screens.dart';
import 'package:do_an_flutter_cuoi_ky/features/auth/services/auth_service.dart';
import 'package:do_an_flutter_cuoi_ky/providers/user_provider.dart';
import 'package:do_an_flutter_cuoi_ky/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/admin/screens/admin_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HS Bookstore',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true, // can remove this line
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
          ? const BottomBar()
          : const AdminScreen()
          : const AuthScreen(),
    );
  }
}