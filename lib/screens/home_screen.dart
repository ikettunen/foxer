import 'package:flutter/material.dart';
import 'map_screen.dart';
import 'lessons_screen.dart';
import 'reading_materials_screen.dart';
import 'discussions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const MapScreen(),
    const LessonsScreen(),
    const ReadingMaterialsScreen(),
    const DiscussionsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.map),
            label: 'Flight Sites',
          ),
          NavigationDestination(
            icon: Icon(Icons.school),
            label: 'Lessons',
          ),
          NavigationDestination(
            icon: Icon(Icons.book),
            label: 'Reading',
          ),
          NavigationDestination(
            icon: Icon(Icons.forum),
            label: 'Discussions',
          ),
        ],
      ),
    );
  }
}
