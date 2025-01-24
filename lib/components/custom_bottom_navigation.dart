// bottom_navigation.dart
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 70, // 네비게이션 바 높이
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey[300]!), // 상단 경계선
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabIcon(
                context,
                index: 0,
                icon: Icons.home,
                isSelected: currentIndex == 0,
              ),
              _buildTabIcon(
                context,
                index: 1,
                icon: Icons.calendar_today,
                isSelected: currentIndex == 1,
              ),
              const SizedBox(width: 60), // 중앙 FAB 공간 확보
              _buildTabIcon(
                context,
                index: 2,
                icon: Icons.people,
                isSelected: currentIndex == 2,
              ),
              _buildTabIcon(
                context,
                index: 3,
                icon: Icons.settings,
                isSelected: currentIndex == 3,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 15,
          child: FloatingActionButton(
            onPressed: () {
              onTabSelected(-1); // 중앙 버튼에 대한 특별한 동작 처리
            },
            backgroundColor: const Color(0xFFBCE4A3),
            child: const Icon(Icons.add, size: 30, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildTabIcon(BuildContext context,
      {required int index, required IconData icon, required bool isSelected}) {
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Icon(
        icon,
        size: 30,
        color: isSelected ? const Color(0xFFFFA726) : Colors.grey,
      ),
    );
  }
}
