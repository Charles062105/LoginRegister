import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task6_loginregister/login.dart';

Future<void> registerAccount(WidgetTester tester) async {
  await tester.tap(find.text('Register').first);
  await tester.pumpAndSettle();

  await tester.enterText(find.byType(TextField).at(0), 'Taylor Quimado');
  await tester.enterText(find.byType(TextField).at(1), 'taylor');
  await tester.enterText(find.byType(TextField).at(2), 'secret123');
  await tester.enterText(find.byType(TextField).at(3), 'secret123');

  final genderDropdown = find.byType(DropdownButtonFormField<String>).at(0);
  await tester.ensureVisible(genderDropdown);
  await tester.tap(genderDropdown);
  await tester.pumpAndSettle();
  await tester.tap(find.text('Male').last);
  await tester.pumpAndSettle();

  final statusDropdown = find.byType(DropdownButtonFormField<String>).at(1);
  await tester.ensureVisible(statusDropdown);
  await tester.tap(statusDropdown);
  await tester.pumpAndSettle();
  await tester.tap(find.text('Single').last);
  await tester.pumpAndSettle();

  final birthdateField = find.byType(TextField).at(4);
  await tester.ensureVisible(birthdateField);
  await tester.tap(birthdateField);
  await tester.pumpAndSettle();
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();

  await tester.tap(find.text('Register').last);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('incorrect password does not log in', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: LoginPage()),
    );
    await registerAccount(tester);

    await tester.enterText(find.byType(TextField).at(0), 'taylor');
    await tester.enterText(find.byType(TextField).at(1), 'wrong-password');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Username or password is incorrect'), findsOneWidget);
    expect(find.text('User Information'), findsNothing);
  });

  testWidgets('registered credentials can log in', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: LoginPage()),
    );
    await registerAccount(tester);

    await tester.enterText(find.byType(TextField).at(0), 'taylor');
    await tester.enterText(find.byType(TextField).at(1), 'secret123');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('User Information'), findsOneWidget);
  });
}
