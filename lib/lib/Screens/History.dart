import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Color(0xFF00BCD4),
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            "This is the History Page",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
