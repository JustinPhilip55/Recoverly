import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recoverly/main.dart'; // Importing main.dart to access MyApp

void main() {
  testWidgets('Test if the app displays the login page',
      (WidgetTester tester) async {
    // Build the app widget and trigger a frame.
    await tester.pumpWidget(MyApp()); // Use MyApp to test the full app flow

    // Verify that the login page is displayed with the correct title.
    expect(find.text('Sign In'),
        findsOneWidget); // Check if "Sign In" text is displayed
    expect(find.text('Sign In Page Content'),
        findsOneWidget); // Check if page content is displayed
  });
}
