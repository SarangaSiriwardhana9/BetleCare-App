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
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.1)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        child: GNav(
          gap: 8,
          backgroundColor: Colors.white,
          color: Colors.grey[800]!,
          activeColor: Colors.green[800]!,
          tabBackgroundColor: Colors.green[100]!,
          tabBorderRadius: 15,
          tabs: [
            GButton(
              icon: LineIcons.leaf,
              iconActiveColor: Colors.green[800],
            ),
            GButton(
              icon: LineIcons.dollarSign,
              iconActiveColor: Colors.green[800],
            ),
            GButton(
              icon: LineIcons.home,
              iconActiveColor: Colors.green[800],
            ),
            GButton(
              icon: LineIcons.bug,
              iconActiveColor: Colors.green[800],
            ),
            GButton(
              icon: LineIcons.cloud,
              iconActiveColor: Colors.green[800],
            )
          ],
          selectedIndex: selectedIndex,
          onTabChange: onTabChange,
          iconSize: selectedIndex == selectedIndex ? 28 : 24,
        ),
      ),
    );
  }
}
