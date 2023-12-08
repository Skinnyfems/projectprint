import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projectprint/splash_screen.dart'; // Sesuaikan dengan path yang benar

void main() {
  testWidgets('Testing SplashScreen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: SplashScreen()));

    // Verify that certain widgets are present on the SplashScreen.
    expect(find.text('PRINT PROJECT'), findsOneWidget);
    expect(find.text('Your additional information or description can go here.'),
        findsOneWidget);

    // You can add more test cases as needed.
  });
}
