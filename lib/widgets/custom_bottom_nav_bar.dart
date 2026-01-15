import 'package:flutter/material.dart';
import 'package:khotwa/core/theme/app_theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final List<Map<String, dynamic>> items = [
    {'icon': Icons.person, 'label': 'الملف الشخصي'},
    {'icon': Icons.meeting_room, 'label': 'المقابلات'},
    {'icon': Icons.shopping_bag, 'label': 'طلباتي'},
    {'icon': Icons.search, 'label': 'بحث'},
    {'icon': Icons.home, 'label': 'الرئيسية'},
  ];

  @override
  Widget build(BuildContext context) {
    final double itemWidth = MediaQuery.of(context).size.width / items.length;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Animated Indicator
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: 20, 
            left: Directionality.of(context) == TextDirection.rtl
                ? null
                : currentIndex * itemWidth + (itemWidth / 2) - 22,
            right: Directionality.of(context) == TextDirection.rtl
                ? currentIndex * itemWidth + (itemWidth / 2) - 22
                : null,

            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFD9E9FB), // Light blue background
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          // Actual Icons
          Row(
            children: List.generate(items.length, (index) {
              final isSelected = index == currentIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon
                      // We can optimize this by not rebuilding everything, but for a nav bar it's fine.
                      Icon(
                        items[index]['icon'],
                        color: isSelected
                            ? AppTheme.lightTheme.primaryColor
                            : Colors.grey,
                        size: 28,
                      ),
                      const SizedBox(height: 4),
                      // Label
                      Text(
                        items[index]['label'],
                        style: TextStyle(
                          color: isSelected
                              ? AppTheme.lightTheme.primaryColor
                              : Colors.grey,
                          fontSize: 12,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
