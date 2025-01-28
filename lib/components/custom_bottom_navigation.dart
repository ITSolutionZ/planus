import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final double fabPosition;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    this.fabPosition = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey[300]!),
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
              const SizedBox(width: 60), // floating button space
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
          bottom: fabPosition,
          child: FloatingActionButton(
            onPressed: () {
              onTabSelected(-1);
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF3E0) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 30,
          color: isSelected ? const Color(0xFFFFA726) : Colors.grey,
        ),
      ),
    );
  }
}
