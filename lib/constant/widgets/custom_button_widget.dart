import 'package:flutter/material.dart';
import 'package:ticket_hub/constant/colors.dart';

class DarkCustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const DarkCustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: 54,
              padding: const EdgeInsets.only(left: 40),
              decoration: BoxDecoration(
                color: blackColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: -4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ClipRect(
                  child: Image.asset(
                    'assets/images/Group2.png',
                    height: 60,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LightCustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LightCustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: blackColor,
                ),
              ),
            ),
            Positioned(
              left: -15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ClipRect(
                  child: Image.asset(
                    'assets/images/Group.png',
                    height: 60,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
