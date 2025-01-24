import 'package:flutter/material.dart';
import 'package:planus/views/calendar_screen.dart';
import 'components/custom_bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(), // 홈 화면
    const CalendarScreen(), // 캘린더 화면
    const Center(child: Text('Friends Page')),
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
            // FloatingActionButton 클릭 시 동작
            debugPrint('FAB Clicked!');
          }
        },
      ),
    );
  }
}
