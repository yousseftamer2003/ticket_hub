import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/controller/auth/list_provider.dart';
import 'package:ticket_hub/controller/auth/login_provider.dart';
import 'package:ticket_hub/controller/auth/otp_provider.dart';
import 'package:ticket_hub/controller/auth/signup_provider.dart';
import 'package:ticket_hub/controller/booking_controller.dart';
import 'package:ticket_hub/controller/data_list_provider.dart';
import 'package:ticket_hub/controller/image_controller.dart';
import 'package:ticket_hub/controller/lang_controller.dart';
import 'package:ticket_hub/controller/points/points_provider.dart';
import 'package:ticket_hub/controller/private/private_list_provider.dart';
import 'package:ticket_hub/controller/profile/profile_provider.dart';
import 'package:ticket_hub/controller/setup_controller.dart';
import 'package:ticket_hub/controller/trips/trips_provider.dart';
import 'package:ticket_hub/controller/wallet/wallet_provider.dart';
import 'package:ticket_hub/generated/l10n.dart';
import 'package:ticket_hub/views/start/screens/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => NationalityProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => ForgotPasswordProvider()),
        ChangeNotifierProvider(create: (context) => BookingController()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => TripsProvider()),
        ChangeNotifierProvider(create: (context) => WalletProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => PointsProvider()),
        ChangeNotifierProvider(create: (context) => CarProvider()),
        ChangeNotifierProvider(create: (context) => LangController()),
        ChangeNotifierProvider(create: (context) => SetupController()),
        ChangeNotifierProvider(create: (context) => ImageController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LangController>(
      builder: (context, langServices, _) {
        return MaterialApp(
        localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: langServices.locale,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
          ),
          home: const SplashScreen()); 
      },
    );
  }
}
