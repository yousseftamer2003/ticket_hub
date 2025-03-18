import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_hub/constant/colors.dart';
import 'package:ticket_hub/views/tabs_screen/screens/home_page.dart';
import 'package:ticket_hub/views/tabs_screen/screens/my_trips_page.dart';
import 'package:ticket_hub/views/tabs_screen/screens/profile_page.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List pages = const [
    HomePage(),
    MyTripsPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: blackColor, 
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem('assets/images/home.svg','assets/images/homeActive.svg' ,"Home", 0),
                  _buildNavItem('assets/images/trips.svg', 'assets/images/tripActive.svg',"My Trips", 1),
                  _buildNavItem('assets/images/profile.svg', 'assets/images/profileActive.svg',"Profile", 2),
                ],
              ),
            ),
            Positioned(
              left: (_selectedIndex == 0)
                  ? MediaQuery.of(context).size.width * 0.037
                  : (_selectedIndex == 1)
                      ? MediaQuery.of(context).size.width * 0.37
                      : MediaQuery.of(context).size.width * 0.71,
              top: 0,
              child: Image.asset(
                'assets/images/pointer.png',
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon,String iconActive ,String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(index == _selectedIndex ? iconActive : icon),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index ? orangeColor : Colors.white,
              fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
