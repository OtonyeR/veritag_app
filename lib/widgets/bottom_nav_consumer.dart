import '../ohome_icons.dart';
import '../test_read_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:veritag_app/utils/constants.dart';
import 'package:veritag_app/views/router_screen.dart';
import 'package:veritag_app/views/consumer_home_page.dart';
import 'package:veritag_app/views/history_page_consumer.dart';


class BottomNavConsumer extends StatefulWidget {
  const BottomNavConsumer({super.key});

  @override
  State<BottomNavConsumer> createState() => _BottomNavConsumerState();
}

class _BottomNavConsumerState extends State<BottomNavConsumer> {
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
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            _buildNavItem(
              icon: Ohome.oc_home,
              label: 'Home',
              index: 0,
            ),
            const Spacer(),
            _buildNavItem(
              icon: IconsaxPlusLinear.clock_1,
              label: 'History',
              index: 1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        foregroundColor: colorBgW,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NFCReadPage(),
            ),
          );
        },
        backgroundColor: colorPrimary,
        child: const Icon(IconsaxPlusBold.scan),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(
      {required IconData icon, required String label, required int index}) {
    return Expanded(
      child: InkWell(
        onTap: () => _handleNavigationChange(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _selectedIndex == index ? colorPrimary : colorBl,
            ),
            Text(
              label,
              style: TextStyle(
                color: _selectedIndex == index ? colorPrimary : colorBl,
              ),
            ),
          ],
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
        return ConsumerHomePage();
      case 1:
        return const HistoryPageConsumer();
      default:
        return const RouterScreen();
    }
  }
}
