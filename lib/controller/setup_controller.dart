import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_hub/views/start/screens/onboarding_screen.dart';
import 'package:ticket_hub/views/tabs_screen/screens/tabs_screen.dart';

class SetupController with ChangeNotifier {
  bool isNewUser = true;

  Future<void> checkFirstTimeUser(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    bool? hasLaunched = prefs.getBool('hasLaunchedBefore');

    if (hasLaunched != null && hasLaunched == true) {
      isNewUser = false;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx)=> const TabsScreen()),
      );
    } else {
      isNewUser = true;
      await prefs.setBool('hasLaunchedBefore', true);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx)=> const OnboardingScreen()),
      );
    }

    notifyListeners();
  }
}
