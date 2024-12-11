import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  BottomNavBar({required this.selectedIndex, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: GNav(
          gap: 8,
          backgroundColor: Colors.white,
          color: Colors.grey[800]!,
          activeColor: Colors.green[800]!,
          tabBackgroundColor: Colors.green[100]!,
          tabBorderRadius: 15,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          tabs: [
            GButton(
              icon: LineIcons.leaf,
              iconActiveColor: Colors.green[800],
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              text: 'Harvest',
            ),
            GButton(
              icon: LineIcons.dollarSign,
              iconActiveColor: Colors.green[800],
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              text: 'Finance',
            ),
            GButton(
              icon: LineIcons.home,
              iconActiveColor: Colors.green[800],
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.bug,
              iconActiveColor: Colors.green[800],
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              text: 'Pests',
            ),
            GButton(
              icon: LineIcons.cloud,
              iconActiveColor: Colors.green[800],
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              text: 'Weather',
            )
          ],
          selectedIndex: selectedIndex,
          onTabChange: onTabChange,
        ),
      ),
    );
  }
}
