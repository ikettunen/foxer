import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      try {
        final prefs = await SharedPreferences.getInstance().timeout(
          const Duration(seconds: 2),
          onTimeout: () => null as dynamic,
        );
        
        bool isLoggedIn = false;
        if (prefs != null) {
          isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
        }
        
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => isLoggedIn ? const HomeScreen() : const LoginScreen(),
            ),
          );
        }
      } catch (e) {
        // If SharedPreferences fails, just go to login
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(
                  Icons.paragliding,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Foxer Paragliding',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
