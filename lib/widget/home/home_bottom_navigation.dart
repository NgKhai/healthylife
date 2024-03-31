import 'package:flutter/material.dart';
import 'package:healthylife/page/bmi/bmi_page.dart';
import 'package:healthylife/page/calo/calo_page.dart';
import 'package:healthylife/page/fat/fat_page.dart';
import 'package:healthylife/page/home/home_page.dart';
import 'package:healthylife/page/food_calo/food_calo.dart';

class HomeBottomNavigation extends StatefulWidget {
  const HomeBottomNavigation({Key? key}) : super(key: key);

  @override
  State<HomeBottomNavigation> createState() => _HomeBottomNavigationState();
}

class _HomeBottomNavigationState extends State<HomeBottomNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    FoodCaloPage(),
    FatPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_outlined),
            label: 'Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.brightness_1),
            label: 'Fat',
          ),
        ],
      ),
    );
  }
}
