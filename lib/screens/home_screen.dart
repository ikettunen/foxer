import 'package:flutter/material.dart';
import 'package:paragliding_training/generated_localizations/app_localizations.dart';
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
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.map),
            label: AppLocalizations.of(context)!.flightSites,
          ),
          NavigationDestination(
            icon: const Icon(Icons.school),
            label: AppLocalizations.of(context)!.lessons,
          ),
          NavigationDestination(
            icon: const Icon(Icons.book),
            label: AppLocalizations.of(context)!.readingMaterials,
          ),
          NavigationDestination(
            icon: const Icon(Icons.forum),
            label: AppLocalizations.of(context)!.discussions,
          ),
        ],
      ),
    );
  }
}
