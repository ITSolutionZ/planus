import 'package:flutter/material.dart';
import 'package:planus/views/home_screen.dart';
import 'package:planus/views/calendar_screen.dart';

import 'package:planus/views/splash_screen.dart';
import 'components/custom_bottom_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const CalendarScreen(),
    const Center(child: Text('Groups Page')),
    const Center(child: Text('Settings Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTabSelected: (index) {
          if (index != -1) {
            setState(() {
              _currentIndex = index;
            });
          } else {
            // fAB button tapped
            debugPrint('FAB Clicked!');
          }
        },
      ),
    );
  }
}
