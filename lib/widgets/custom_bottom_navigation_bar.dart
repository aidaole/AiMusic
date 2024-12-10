import 'package:flutter/material.dart';

import '../themes/theme_size.dart';

/// 底部导航项数据模型
class CustomBottomNavigationBarItem {
  final Widget icon;
  final Widget? activeIcon;
  final String? label;

  const CustomBottomNavigationBarItem({
    required this.icon,
    this.activeIcon,
    this.label,
  });
}

class CustomBottomNavigationBar extends StatelessWidget {
  final List<CustomBottomNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? elevation;

  const CustomBottomNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor,
    this.selectedItemColor = Colors.white,
    this.unselectedItemColor = Colors.white70,
    this.elevation = 0,
  }) : assert(items.length >= 2, '至少需要2个导航项');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: defaultBottomNavigationBarHeight,
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: elevation! > 0
              ? [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: elevation!,
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            items.length,
            (index) => _buildNavigationItem(index),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItem(int index) {
    final bool isSelected = currentIndex == index;
    final item = items[index];

    return InkWell(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isSelected && item.activeIcon != null
                ? item.activeIcon!
                : IconTheme(
                    data: IconThemeData(
                      color:
                          isSelected ? selectedItemColor : unselectedItemColor,
                    ),
                    child: item.icon,
                  ),
            if (item.label != null) ...[
              Text(
                item.label!,
                style: TextStyle(
                  color: isSelected ? selectedItemColor : unselectedItemColor,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
