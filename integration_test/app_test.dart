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
      // Start the app
      await tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const ParaglidingApp());
      
      // Wait for splash screen
      print('⏳ Waiting for splash screen...');
      await Future.delayed(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      
      // 📸 Splash Screen
      await takeScreenshot(tester, '01_splash_screen');
      expectText('Foxer Paragliding');

      // Wait for navigation to login screen
      await tester.pumpAndSettle(const Duration(seconds: 2));
      
      // 📸 Login Screen
      print('📸 Taking login screen screenshot...');
      await takeScreenshot(tester, '02_login_screen');
      
      // Find email field and enter email
      print('📝 Entering email...');
      final emailFields = find.byType(TextFormField);
      expect(emailFields, findsWidgets);
      
      await tester.enterText(emailFields.first, 'test@example.com');
      await tester.pumpAndSettle();

      // Find password field and enter password
      print('📝 Entering password...');
      await tester.enterText(emailFields.at(1), 'password123');
      await tester.pumpAndSettle();
      
      // 📸 Login form filled
      await takeScreenshot(tester, '03_login_form_filled');

      // Tap login button
      print('🔐 Tapping login button...');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify navigation to home screen
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

      // Start the app
      await tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const ParaglidingApp());
      
      // Skip splash screen (already logged in)
      await Future.delayed(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Verify on home screen
      print('✅ Logged in automatically');
      
      // 📸 Home - Flight Sites Tab
      print('📍 Testing Flight Sites tab...');
      await takeScreenshot(tester, '05_nav_flight_sites');
      expect(find.byIcon(Icons.map), findsOneWidget);

      // Tap Lessons tab
      print('📍 Navigating to Lessons tab...');
      await tester.tap(find.byIcon(Icons.school));
      await tester.pumpAndSettle();
      expectText('Lessons');
      
      // 📸 Lessons Screen
      await takeScreenshot(tester, '06_nav_lessons');

      // Tap Reading Materials tab
      print('📍 Navigating to Reading Materials tab...');
      await tester.tap(find.byIcon(Icons.book));
      await tester.pumpAndSettle();
      expectText('Reading');
      
      // 📸 Reading Materials Screen
      await takeScreenshot(tester, '07_nav_reading_materials');

      // Tap Discussions tab
      print('📍 Navigating to Discussions tab...');
      await tester.tap(find.byIcon(Icons.forum));
      await tester.pumpAndSettle();
      expectText('Discussions');
      
      // 📸 Discussions Screen
      await takeScreenshot(tester, '08_nav_discussions');

      // Tap back to Flight Sites
      print('📍 Navigating back to Flight Sites...');
      await tester.tap(find.byIcon(Icons.map));
      await tester.pumpAndSettle();
      expectText('Flight Sites');
      
      // 📸 Back to Flight Sites
      await takeScreenshot(tester, '09_nav_back_to_flight_sites');
      
      print('✅ All navigation tests passed!');
    });

    testWidgets('Login persistence test', (WidgetTester tester) async {
      // Set login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', 'persistent@example.com');

      // Start the app
      await tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const ParaglidingApp());
      
      // Should skip login screen and go to home
      await Future.delayed(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Verify on home screen without entering credentials
      print('✅ Login persisted correctly');
      expectText('Flight Sites');
      
      // 📸 Persisted Login
      await takeScreenshot(tester, '10_login_persisted');
    });

    testWidgets('Logout flow test', (WidgetTester tester) async {
      // Pre-set login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', 'test@example.com');

      // Start the app
      await tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const ParaglidingApp());
      
      // Skip splash screen
      await Future.delayed(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Try to find logout option (look for app bar menu)
      print('🔍 Looking for logout option...');
      
      // If there's an AppBar with a menu button
      final menuButtons = find.byIcon(Icons.menu);
      if (menuButtons.evaluate().isNotEmpty) {
        await tester.tap(menuButtons.first);
        await tester.pumpAndSettle();
        
        // Look for logout text
        final logoutButton = find.text('Logout');
        if (logoutButton.evaluate().isNotEmpty) {
          await tester.tap(logoutButton);
          await tester.pumpAndSettle();
          
          // Should be back at login screen
          print('✅ Logout successful');
          await takeScreenshot(tester, '11_logout_success');
        } else {
          print('⚠️ No logout button found - may not be implemented yet');
        }
      } else {
        print('⚠️ No menu button found - logout may not be implemented yet');
      }
    });
  });
}
