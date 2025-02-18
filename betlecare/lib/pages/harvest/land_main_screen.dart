import 'package:betlecare/pages/harvest/land_details_screen.dart';
import 'package:flutter/material.dart';

import '../../widgets/appbar/app_bar.dart';
import 'harvest_screen.dart';
import 'land_measurement_screen.dart';
import 'manual_land_measurement_page.dart';

class LandMainScreen extends StatelessWidget {
  const LandMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildCard(
                      context: context,
                      title: 'සිතියම මත පදනම්\n වූ ඉඩම් මැනීම',
                      color: Colors.blue.shade100,
                      imagePath: 'assets/images/eshan/LM5.png',
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade50, Colors.blue.shade100],
                      ),
                      onTap: () => _navigateTo(context, const ManualLandMeasurementPage()),
                    ),
                    const SizedBox(height: 16),
                    _buildCard(
                      context: context,
                      title: 'GPS මත පදනම්\n වූ ඉඩම් මැනීම',
                      color: Colors.purple.shade100,
                      imagePath: 'assets/images/eshan/LM6.png',
                      gradient: LinearGradient(
                        colors: [Colors.purple.shade50, Colors.purple.shade100],
                      ),
                      onTap: () => _navigateTo(context, const LandMeasurementScreen()),
                    ),
                    const SizedBox(height: 16),
                    _buildCard(
                      context: context,
                      title: 'ඉඩම් විස්තර',
                      color: Colors.green.shade100,
                      imagePath: 'assets/images/eshan/LM7.png',
                      gradient: LinearGradient(
                        colors: [Colors.green.shade50, Colors.green.shade100],
                      ),
                      onTap: () => _navigateTo(context, const LandDetailsScreen()),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChildPageWrapper(child: page),
      ),
    );
  }

  Widget _buildCard({
    required BuildContext context,
    required String title,
    required Color color,
    required String imagePath,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 120, maxHeight: 180),
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
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      height: 1.3,
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

