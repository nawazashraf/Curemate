import 'package:flutter/material.dart';

class Hospital extends StatelessWidget {
  const Hospital({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Hospitals'),
        backgroundColor: Color(0xFF00BCD4),
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            "This is the Hospital Page",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
