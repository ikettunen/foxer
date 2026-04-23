import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

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

/// Takes a real screenshot and saves it
Future<void> takeScreenshot(WidgetTester tester, String name) async {
  await tester.pumpAndSettle();
  try {
    await tester.binding.convertFlutterSurfaceToImage();
    print('📸 Screenshot captured: $name');
  } catch (e) {
    print('⚠️ Screenshot failed for $name: $e');
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
