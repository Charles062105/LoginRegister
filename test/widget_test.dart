import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task6_loginregister/login.dart';

void main() {
  testWidgets('Login Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    expect(find.text('Quimado'), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
  });

  testWidgets('Register Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    await tester.tap(find.text("Don't have an account? Register"));
    await tester.pumpAndSettle();

    expect(find.text('REGISTER'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
  });

  testWidgets('Login to Home Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to the Main Page!'), findsOneWidget);
  });
}