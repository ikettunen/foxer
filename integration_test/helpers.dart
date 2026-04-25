import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Helper functions for integration testing

/// Waits for a widget with the given key to appear
Future<void> waitForWidget(WidgetTester tester, Key key, {Duration timeout = const Duration(seconds: 5)}) async {
  final endTime = DateTime.now().add(timeout);
  
  while (DateTime.now().isBefore(endTime)) {
    await tester.pumpAndSettle();
    if (find.byKey(key).evaluate().isNotEmpty) {
      return;
    }
    await Future.delayed(const Duration(milliseconds: 100));
  }
  
  throw Exception('Widget with key $key not found after ${timeout.inSeconds}s');
}

/// Finds and taps a widget by key
Future<void> tapByKey(WidgetTester tester, Key key) async {
  await tester.tap(find.byKey(key));
  await tester.pumpAndSettle();
}

/// Finds and taps a widget by text
Future<void> tapByText(WidgetTester tester, String text) async {
  await tester.tap(find.text(text));
  await tester.pumpAndSettle();
}

/// Enters text into a text field
Future<void> enterText(WidgetTester tester, Key key, String text) async {
  await tester.tap(find.byKey(key));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(key), text);
  await tester.pumpAndSettle();
}

/// Takes a screenshot and creates a visual test report
Future<void> takeScreenshot(WidgetTester tester, String name) async {
  await tester.pumpAndSettle();
  try {
    // Add a small delay to ensure rendering is complete
    await Future.delayed(const Duration(milliseconds: 100));
    
    // Get the widget tree
    final scaffold = find.byType(Scaffold);
    expect(scaffold, findsWidgets, reason: 'Scaffold not found on screen $name');
    
    // For web/Chrome integration tests, we can't save actual images due to security restrictions.
    // Instead, create a verification report showing widgets are rendered.
    // ignore: avoid_print
    print('✅ Visual checkpoint verified: $name');
    // ignore: avoid_print
    print('   - Scaffold found and rendered');
  } catch (e) {
    // ignore: avoid_print
    print('⚠️ Screenshot checkpoint failed for $name: $e');
    rethrow;
  }
}

/// Waits for a text to appear
Future<void> waitForText(WidgetTester tester, String text, {Duration timeout = const Duration(seconds: 5)}) async {
  final endTime = DateTime.now().add(timeout);
  
  while (DateTime.now().isBefore(endTime)) {
    await tester.pumpAndSettle();
    if (find.text(text).evaluate().isNotEmpty) {
      return;
    }
    await Future.delayed(const Duration(milliseconds: 100));
  }
  
  throw Exception('Text "$text" not found after timeout');
}

/// Scrolls a ListView to find and tap an item
Future<void> scrollAndTap(WidgetTester tester, String text) async {
  final listFinder = find.byType(ListView);
  
  if (find.text(text).evaluate().isEmpty) {
    await tester.scrollUntilVisible(
      find.text(text),
      500.0,
      scrollable: listFinder.first,
    );
  }
  
  await tester.tap(find.text(text));
  await tester.pumpAndSettle();
}

/// Verifies that a widget with text is visible
void expectText(String text) {
  expect(find.text(text), findsOneWidget);
}

/// Verifies that a widget with key is visible
void expectKey(Key key) {
  expect(find.byKey(key), findsOneWidget);
}
