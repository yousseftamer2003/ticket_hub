import 'package:flutter/material.dart';
import 'package:ticket_hub/constant/colors.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: [
            SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.25,
                child: Image.asset(
                  'assets/images/homebackground.png',
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ticket Hub',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: orangeColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            '30 Points',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Ticket easy',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Comfortable and easy trips, book now andenjoy a unique travel experience!',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        );
  }
}