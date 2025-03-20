import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/controller/auth/list_provider.dart';
import 'package:ticket_hub/controller/auth/login_provider.dart';
import 'package:ticket_hub/controller/auth/otp_provider.dart';
import 'package:ticket_hub/controller/auth/signup_provider.dart';
import 'package:ticket_hub/views/start/screens/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => NationalityProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => ForgotPasswordProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        ),
        home: const SplashScreen());
  }
}
