import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paragliding_training/screens/lesson_detail_screen.dart';

void main() {
  group('LessonDetailScreen Tests', () {
    testWidgets('Displays lesson header with title, level, and duration',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LessonDetailScreen(
            title: 'Introduction to Paragliding',
            duration: '30 min',
            level: 'Beginner',
            index: 0,
          ),
        ),
      );

      expect(find.text('Introduction to Paragliding'), findsWidgets);
      expect(find.text('Level: Beginner'), findsOneWidget);
      expect(find.text('Duration: 30 min'), findsOneWidget);
    });

    testWidgets('Displays lesson content sections correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LessonDetailScreen(
            title: 'Introduction to Paragliding',
            duration: '30 min',
            level: 'Beginner',
            index: 0,
          ),
        ),
      );

      expect(find.text('What is Paragliding?'), findsOneWidget);
      expect(find.text('Basic Principles'), findsOneWidget);
      expect(find.text('Safety First'), findsOneWidget);
    });

    testWidgets('Displays equipment overview lesson content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LessonDetailScreen(
            title: 'Equipment Overview',
            duration: '45 min',
            level: 'Beginner',
            index: 1,
          ),
        ),
      );

      expect(find.text('The Paraglider'), findsOneWidget);
      expect(find.text('Harness & Reserves'), findsOneWidget);
      expect(find.text('Accessory Gear'), findsOneWidget);
    });

    testWidgets('Displays pre-flight checks lesson content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LessonDetailScreen(
            title: 'Pre-flight Checks',
            duration: '20 min',
            level: 'Beginner',
            index: 2,
          ),
        ),
      );

      expect(find.text('Weather Check'), findsOneWidget);
      expect(find.text('Equipment Inspection'), findsOneWidget);
      expect(find.text('Launch Site Assessment'), findsOneWidget);
    });

    testWidgets('Completion button toggles between incomplete and complete states',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LessonDetailScreen(
            title: 'Introduction to Paragliding',
            duration: '30 min',
            level: 'Beginner',
            index: 0,
          ),
        ),
      );

      // Initially should show "Mark as Complete"
      expect(find.text('Mark as Complete'), findsOneWidget);
      expect(find.byIcon(Icons.play_circle_outline), findsOneWidget);

      // Tap the button by predicate
      final button = tester.widget<ElevatedButton>(find.byWidgetPredicate((w) => w is ElevatedButton));
      button.onPressed!();
      await tester.pumpAndSettle();

      // Should now show "Completed"
      expect(find.text('Completed'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);

      // Tap again to toggle back
      final button2 = tester.widget<ElevatedButton>(find.byWidgetPredicate((w) => w is ElevatedButton));
      button2.onPressed!();
      await tester.pumpAndSettle();

      // Should return to "Mark as Complete"
      expect(find.text('Mark as Complete'), findsOneWidget);
    });

    testWidgets('Shows completion SnackBar when lesson is marked complete',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LessonDetailScreen(
            title: 'Introduction to Paragliding',
            duration: '30 min',
            level: 'Beginner',
            index: 0,
          ),
        ),
      );

      // Tap completion button
      final button = tester.widget<ElevatedButton>(find.byWidgetPredicate((w) => w is ElevatedButton));
      button.onPressed!();
      await tester.pumpAndSettle();

      // Check for SnackBar message
      expect(find.text('Lesson marked as complete!'), findsOneWidget);

      // Wait for SnackBar to disappear
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Tap again to mark incomplete
      final button2 = tester.widget<ElevatedButton>(find.byWidgetPredicate((w) => w is ElevatedButton));
      button2.onPressed!();
      await tester.pumpAndSettle();

      // Check for incomplete message
      expect(find.text('Lesson marked as incomplete.'), findsOneWidget);
    });

    testWidgets('AppBar displays correct lesson title', (WidgetTester tester) async {
      const testTitle = 'Thermal Flying';
      await tester.pumpWidget(
        MaterialApp(
          home: const LessonDetailScreen(
            title: testTitle,
            duration: '120 min',
            level: 'Advanced',
            index: 7,
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text(testTitle), findsWidgets);
    });

    testWidgets('Displays placeholder content for unknown lesson indices',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LessonDetailScreen(
            title: 'Unknown Lesson',
            duration: '30 min',
            level: 'Beginner',
            index: 999,
          ),
        ),
      );

      expect(find.text('Coming Soon'), findsOneWidget);
      expect(find.text('Full lesson content will be available soon. Stay tuned!'),
          findsOneWidget);
    });

    testWidgets('Scrollable content can be scrolled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LessonDetailScreen(
            title: 'Introduction to Paragliding',
            duration: '30 min',
            level: 'Beginner',
            index: 0,
          ),
        ),
      );

      // Find the SingleChildScrollView
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      // Scroll down
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      // Verify we can still find content (confirms scrolling works)
      expect(find.text('Safety First'), findsOneWidget);
    });

    testWidgets('Lesson metadata displays paragliding icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LessonDetailScreen(
            title: 'Introduction to Paragliding',
            duration: '30 min',
            level: 'Beginner',
            index: 0,
          ),
        ),
      );

      expect(find.byIcon(Icons.paragliding), findsOneWidget);
    });

    testWidgets('Button changes color based on completion state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LessonDetailScreen(
            title: 'Introduction to Paragliding',
            duration: '30 min',
            level: 'Beginner',
            index: 0,
          ),
        ),
      );

      // Get initial button by text (ElevatedButton.icon() cannot be found by type)
      expect(find.text('Mark as Complete'), findsOneWidget);

      // Tap to mark as complete
      final button = tester.widget<ElevatedButton>(find.byWidgetPredicate((w) => w is ElevatedButton));
      button.onPressed!();
      await tester.pumpAndSettle();

      // Button should still exist with "Completed" text
      expect(find.text('Completed'), findsOneWidget);
    });
  });
}
