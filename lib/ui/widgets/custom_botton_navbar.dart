import 'package:flutter/material.dart';
import 'package:m_espresso_v1/ui/theme/app_theme.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  final int currentIndex;
  final Function(int) onTap;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    const selectedColor = Apptheme.iconActiveColor;
    const unSelectedColor = Apptheme.iconColor;

    return SizedBox(
      height: 120,
      child: StylishBottomBar(
        backgroundColor: const Color(0xff0D1015),
        items: [
          BottomBarItem(
            icon: const Icon(Icons.home),
            selectedIcon: const Icon(Icons.home),
            selectedColor: selectedColor,
            unSelectedColor: unSelectedColor,
            title: const Text('All'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.coffee_sharp),
            selectedIcon: const Icon(Icons.coffee_sharp),
            selectedColor: selectedColor,
            unSelectedColor: unSelectedColor,
            title: const Text('Completed'),
          ),
          // BottomBarItem(
          //   icon: const Icon(Icons.dashboard),
          //   selectedIcon: const Icon(Icons.dashboard),
          //   selectedColor: selectedColor,
          //   unSelectedColor: unSelectedColor,
          //   title: const Text('Dashboard'),
          // ),
          // BottomBarItem(
          //   icon: const Icon(Icons.notification_add_rounded),
          //   selectedIcon: const Icon(Icons.notification_add_rounded),
          //   selectedColor: selectedColor,
          //   unSelectedColor: unSelectedColor,
          //   title: const Text('Reminders'),
          // ),
        ],
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        currentIndex: widget.currentIndex,
        onTap: widget.onTap,
        option: AnimatedBarOptions(
          iconSize: 25,
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.simple,
          opacity: 0.4,
        ),
      ),
    );
  }
}
