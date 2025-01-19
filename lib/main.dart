import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'sign_in.dart'; // Updated import to point to the correct sign_in.dart file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Make sure Firebase is initialized
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recoverly',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignInPage(), // Set SignInPage as the initial page
    );
  }
}
