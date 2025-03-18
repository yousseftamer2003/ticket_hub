import 'package:flutter/material.dart';
import 'package:ticket_hub/views/tabs_screen/widgets/home_header_widget.dart';
import 'package:ticket_hub/views/tabs_screen/widgets/tab_content.dart';

enum MenuItem { all, hiace, bus, train }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedContent() {
    switch (_selectedIndex) {
      case 1:
        return const TabContent();
      case 2:
        return const TabContent();
      case 3:
        return const TabContent();
      default:
        return const TabContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const HomeHeaderWidget(), // Background Header
        Positioned(
          top: MediaQuery.sizeOf(context).height * 0.26,
          left: MediaQuery.sizeOf(context).width * 0.04,
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.92,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(MenuItem.values.length, (index) {
                  final menuItem = MenuItem.values[index];
                  final bool isSelected = _selectedIndex == index;

                  return GestureDetector(
                    onTap: () => _onItemTapped(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.orange : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          menuItem.name.toUpperCase(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.sizeOf(context).height * 0.36,
          left: 0,
          right: 0,
          child: _getSelectedContent(),
        ),
      ],
    );
  }
}
