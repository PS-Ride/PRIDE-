import 'package:flutter/material.dart';

void main() {
  runApp(const PrideApp());
}

class PrideApp extends StatelessWidget {
  const PrideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text("PRIDE App"),
        ),
      ),
    );
  }
}
