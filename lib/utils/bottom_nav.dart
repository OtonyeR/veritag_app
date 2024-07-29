import 'package:flutter/material.dart';
import 'package:veritag_app/utils/constants.dart';
import 'package:veritag_app/views/dummy_content.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() {
    return _BottomNavState();
  }
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        child: _getCurrentScreen(),
      ),
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(
            selectedForegroundColor: colorBgW,
            backgroundColor: colorPrimary,
            unselectedForegroundColor: colorSec,
              icon: Icons.home_outlined,
              extras: {"label": "Home"}),
          FluidNavBarIcon(
              icon: Icons.calendar_today_outlined,
              extras: {"label": "History"}),
          FluidNavBarIcon(
              icon: Icons.lightbulb_outline_rounded,
              extras: {"label": "Activity"}),
        ],
        onChange: _handleNavigationChange,
        style: const FluidNavBarStyle(
            barBackgroundColor: Colors.white,
            iconUnselectedForegroundColor: colorBl,
            iconSelectedForegroundColor: colorPrimary),
        scaleFactor: 1.5,
        defaultIndex: _selectedIndex,
        itemBuilder: (icon, item) => Semantics(
          label: icon.extras!["label"],
          child: item,
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getCurrentScreen() {
    switch (_selectedIndex) {
      case 0:
        return const DummyScreen();
      case 1:
        return const DummyScreen(); // Replace with actual screen
      case 2:
        return const DummyScreen(); // Replace with actual screen
      default:
        return const DummyScreen();
    }
  }
}
