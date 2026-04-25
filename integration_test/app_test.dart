import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:paragliding_training/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Paragliding Training App - E2E Tests', () {
    setUp(() async {
      // Clear SharedPreferences before each test
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    });

    testWidgets('Login flow test', (WidgetTester tester) async {
      await tester.pumpWidget(const ParaglidingApp());
      
      // Wait for splash screen to complete (2s delay + navigation)
      // ignore: avoid_print
      print('⏳ Waiting for splash screen...');
      await tester.pumpAndSettle(const Duration(seconds: 3));
      
      // 📸 Splash Screen
      await takeScreenshot(tester, '01_splash_screen');
      expectText('Foxer Paragliding');

      // Wait for navigation to login screen
      await tester.pumpAndSettle(const Duration(seconds: 2));
      
      // 📸 Login Screen
      // ignore: avoid_print
      print('📸 Taking login screen screenshot...');
      await takeScreenshot(tester, '02_login_screen');
      
      // Find email field and enter email
      // ignore: avoid_print
      print('📝 Entering email...');
      final emailFields = find.byType(TextFormField);
      expect(emailFields, findsWidgets);
      
      await tester.enterText(emailFields.first, 'test@example.com');
      await tester.pumpAndSettle();

      // Find password field and enter password
      // ignore: avoid_print
      print('📝 Entering password...');
      await tester.enterText(emailFields.at(1), 'password123');
      await tester.pumpAndSettle();
      
      // 📸 Login form filled
      await takeScreenshot(tester, '03_login_form_filled');

      // Tap login button
      // ignore: avoid_print
      print('🔐 Tapping login button...');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify navigation to home screen
      // ignore: avoid_print
      print('✅ Verifying login success...');
      expectText('Flight Sites');
      
      // 📸 Home Screen - Flight Sites
      await takeScreenshot(tester, '04_home_flight_sites');
    });

    testWidgets('Navigation test', (WidgetTester tester) async {
      // Pre-set login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', 'test@example.com');

      await tester.pumpWidget(const ParaglidingApp());
      
      // Skip splash screen (already logged in)
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify on home screen
      // ignore: avoid_print
      print('✅ Logged in automatically');
      
      // 📸 Home - Flight Sites Tab
      // ignore: avoid_print
      print('📍 Testing Flight Sites tab...');
      await takeScreenshot(tester, '05_nav_flight_sites');
      expect(find.byIcon(Icons.map), findsOneWidget);

      // Tap Lessons tab
      // ignore: avoid_print
      print('📍 Navigating to Lessons tab...');
      await tester.tap(find.byIcon(Icons.school));
      await tester.pumpAndSettle();
      expectText('Lessons');
      
      // 📸 Lessons Screen
      await takeScreenshot(tester, '06_nav_lessons');

      // Tap Reading Materials tab
      // ignore: avoid_print
      print('📍 Navigating to Reading Materials tab...');
      await tester.tap(find.byIcon(Icons.book));
      await tester.pumpAndSettle();
      expectText('Reading');
      
      // 📸 Reading Materials Screen
      await takeScreenshot(tester, '07_nav_reading_materials');

      // Tap Discussions tab
      // ignore: avoid_print
      print('📍 Navigating to Discussions tab...');
      await tester.tap(find.byIcon(Icons.forum));
      await tester.pumpAndSettle();
      expectText('Discussions');
      
      // 📸 Discussions Screen
      await takeScreenshot(tester, '08_nav_discussions');

      // Tap back to Flight Sites
      // ignore: avoid_print
      print('📍 Navigating back to Flight Sites...');
      await tester.tap(find.byIcon(Icons.map));
      await tester.pumpAndSettle();
      expectText('Flight Sites');
      
      // 📸 Back to Flight Sites
      await takeScreenshot(tester, '09_nav_back_to_flight_sites');
      
      // ignore: avoid_print
      print('✅ All navigation tests passed!');
    });

    testWidgets('Login persistence test', (WidgetTester tester) async {
      // Set login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', 'persistent@example.com');

      await tester.pumpWidget(const ParaglidingApp());
      
      // Should skip login screen and go to home
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify on home screen without entering credentials
      // ignore: avoid_print
      print('✅ Login persisted correctly');
      expectText('Flight Sites');
      
      // 📸 Persisted Login
      await takeScreenshot(tester, '10_login_persisted');
    });

    // Note: Logout test is skipped because the app doesn't currently have
    // a logout feature. Uncomment and implement when logout is added to the app.
  });
}
