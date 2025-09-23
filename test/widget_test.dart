// This is a basic Flutter widget test for Inka Max app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:inka_max/main.dart';

void main() {
  testWidgets('Inka Max app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const InkaMaxApp());

    // Verify that the app loads with the main navigation screen
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Nest'), findsOneWidget);
    expect(find.text('Insights'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('Add entry button test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const InkaMaxApp());

    // Find and tap the add entry floating action button
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    // Verify that the add entry screen opens
    expect(find.text('Add New Entry'), findsOneWidget);
    expect(find.text('What are you grateful for today?'), findsOneWidget);
  });
}
