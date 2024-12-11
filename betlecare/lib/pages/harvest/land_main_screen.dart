import 'package:flutter/material.dart';

import 'harvest_screen.dart';
import 'land_measurement_screen.dart';
import 'manual_land_measurement_page.dart';

class LandMainScreen extends StatelessWidget {
  const LandMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildCard(
                    title: 'සිතියම මත පදනම්\n වූ ඉඩම් මැනීම',
                    color: Colors.blue.shade100,
                    imagePath: 'assets/images/eshan/LM5.png',
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade50,
                        Colors.blue.shade100,
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChildPageWrapper(
                            child: ManualLandMeasurementPage(),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildCard(
                    title: 'GPS මත පදනම්\n වූ ඉඩම් මැනීම',
                    color: Colors.purple.shade100,
                    imagePath: 'assets/images/eshan/LM6.png',
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple.shade50,
                        Colors.purple.shade100,
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChildPageWrapper(
                            child: LandMeasurementScreen(),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 16,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back when the button is pressed
              },
              backgroundColor: Colors.green[100]!,
              child: const Icon(Icons.arrow_back), // Back icon for FAB
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required Color color,
    required String imagePath,
    required Gradient gradient,
    required Function()? onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                SizedBox(
                  width: 160,
                  height: 160,
                  child: Center(
                    child: Image.asset(
                      imagePath,
                      width: 160,
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
