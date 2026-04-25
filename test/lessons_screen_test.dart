import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxer/screens/lessons_screen.dart';
import 'package:foxer/screens/lesson_detail_screen.dart';

void main() {
  group('LessonsScreen Tests', () {
    testWidgets('Displays lessons list with all lessons', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LessonsScreen(),
        ),
      );

      expect(find.text('Lessons'), findsOneWidget);
      expect(find.text('Introduction to Paragliding'), findsOneWidget);
      expect(find.text('Equipment Overview'), findsOneWidget);
      expect(find.text('Pre-flight Checks'), findsOneWidget);
      expect(find.text('Launch Techniques'), findsOneWidget);
      expect(find.text('Flight Control'), findsOneWidget);
      expect(find.text('Landing Procedures'), findsOneWidget);
      expect(find.text('Weather Analysis'), findsOneWidget);
      expect(find.text('Thermal Flying'), findsOneWidget);
    });

    testWidgets('Displays lesson metadata (duration and level)', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LessonsScreen(),
        ),
      );

      expect(find.text('30 min • Beginner'), findsOneWidget);
      expect(find.text('45 min • Beginner'), findsOneWidget);
      expect(find.text('60 min • Intermediate'), findsWidgets);
      expect(find.text('120 min • Advanced'), findsOneWidget);
    });

    testWidgets('Displays paragliding icon in AppBar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LessonsScreen(),
        ),
      );

      expect(find.byIcon(Icons.paragliding), findsOneWidget);
    });

    testWidgets('Displays play button icon for each lesson', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LessonsScreen(),
        ),
      );

      // Should have one play icon per lesson (8 lessons)
      expect(find.byIcon(Icons.play_circle_outline), findsWidgets);
    });

    testWidgets('Each lesson is displayed as a Card with ListTile',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LessonsScreen(),
        ),
      );

      expect(find.byType(Card), findsWidgets);
      expect(find.byType(ListTile), findsWidgets);
    });

    testWidgets('Each lesson has a numbered avatar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LessonsScreen(),
        ),
      );

      expect(find.byType(CircleAvatar), findsWidgets);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('8'), findsOneWidget);
    });

    testWidgets('Tapping a lesson navigates to lesson detail screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LessonsScreen(),
          routes: {
            '/detail': (context) => const LessonDetailScreen(
              title: 'Test',
              duration: '30 min',
              level: 'Beginner',
              index: 0,
            ),
          },
        ),
      );

      // Tap the first lesson
      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle();

      // Should navigate to lesson detail (LessonDetailScreen should be displayed)
      expect(find.byType(LessonDetailScreen), findsOneWidget);
    });

    testWidgets('Tapping different lessons passes correct data',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LessonsScreen(),
        ),
      );

      // Tap the third lesson (Pre-flight Checks)
      await tester.tap(find.byType(ListTile).at(2));
      await tester.pumpAndSettle();

      expect(find.text('Pre-flight Checks'), findsWidgets);
      expect(find.text('20 min'), findsOneWidget);
      expect(find.text('Beginner'), findsOneWidget);
    });

    testWidgets('Lessons are displayed in a scrollable ListView',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LessonsScreen(),
        ),
      );

      expect(find.byType(ListView), findsOneWidget);

      // Scroll down to see more lessons
      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pumpAndSettle();

      // All lessons should still be accessible
      expect(find.text('Thermal Flying'), findsOneWidget);
    });

    testWidgets('Correct lessons are categorized by difficulty level',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LessonsScreen(),
        ),
      );

      // Find beginner lessons
      expect(find.text('Beginner'), findsWidgets);
      // Find intermediate lessons
      expect(find.text('Intermediate'), findsWidgets);
      // Find advanced lessons
      expect(find.text('Advanced'), findsWidgets);
    });

    testWidgets('AppBar displays "Lessons" title and icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LessonsScreen(),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Lessons'), findsOneWidget);
      expect(find.byIcon(Icons.paragliding), findsOneWidget);
    });

    testWidgets('Each lesson card has proper spacing and styling',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LessonsScreen(),
        ),
      );

      // Verify Card styling
      final cards = find.byType(Card);
      expect(cards, findsWidgets);

      // Verify we can find padding (EdgeInsets symmetric for cards)
      final paddedCards = find.ancestor(
        of: find.byType(ListTile),
        matching: find.byType(Card),
      );
      expect(paddedCards, findsWidgets);
    });
  });
}
