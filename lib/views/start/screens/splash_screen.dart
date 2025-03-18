import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticket_hub/constant/colors.dart';
import 'package:ticket_hub/views/start/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    _animation = Tween<double>(begin: 0, end: 4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.addListener(() {
      if (_controller.isCompleted) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx)=> const OnboardingScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Color.lerp(blackColor, Colors.white, _controller.value),
          body: Center(
            child: Transform.scale(
              scale: _animation.value,
              child: SvgPicture.asset('assets/images/splashSvg.svg'),
            ),
          ),
        );
      },
    );
  }
}
