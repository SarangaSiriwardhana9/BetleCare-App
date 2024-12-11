import 'package:flutter/material.dart';
import 'package:betlecare/pages/harvest/harvest_screen.dart';
import 'package:betlecare/pages/home_screen.dart';
import 'package:betlecare/pages/profile_screen.dart';
import 'package:betlecare/pages/splash_screen.dart';
import 'package:betlecare/widgets/bottom_nav_bar.dart';
import 'package:betlecare/widgets/profile_header.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // List of screens to navigate between
  final List<Widget> _screens = [
    HarvestScreen(),
    ProfileScreen(),
    HomeScreen(),
    ProfileScreen(),
    ProfileScreen(),
  ];

  // Function to handle tab changes
  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ProfileHeader(), // ProfileHeader is fixed at the top
          Expanded(
            child: _screens[_selectedIndex], // Dynamic content based on selected tab
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: _onTabChange,
      ),
    );
  }
}
