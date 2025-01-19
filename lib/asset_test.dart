import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Asset Test')),
        body: Center(
          child: Image.asset(
            'lib/assets/sign_in_assets/icons/XMLID_28.png', // Ensure this is the correct path
            height: 100, // You can adjust the size for testing
          ),
        ),
      ),
    );
  }
}
