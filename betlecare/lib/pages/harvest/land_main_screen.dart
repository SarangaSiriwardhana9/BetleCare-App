import 'package:flutter/material.dart';

class LandMainScreen extends StatelessWidget {
  const LandMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Land Main Screen")), // Optional: Keep app bar if needed
      body: Center(child: Text('Land Main Content')), // Your page content here
    );
  }
}
