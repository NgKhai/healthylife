import 'package:flutter/material.dart';
import 'package:healthylife/model/UserHealthy.dart';
import 'package:healthylife/page/bmi/bmi_page.dart';
import 'package:healthylife/page/calo/calo_page.dart';
import 'package:healthylife/page/fat/fat_page.dart';
import 'package:healthylife/page/home/home_page.dart';
import 'package:healthylife/page/food_calo/food_calo.dart';
import 'package:healthylife/page/setting/setting_page.dart';
import 'package:healthylife/page/walking/walking_page.dart';

class HomeBottomNavigation extends StatefulWidget {

  UserHealthy userHealthy;
  HomeBottomNavigation({required this.userHealthy});

  @override
  State<HomeBottomNavigation> createState() => _HomeBottomNavigationState();
}

class _HomeBottomNavigationState extends State<HomeBottomNavigation> {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  late List<Widget> _pages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();

  }


  void fetchData() {
    _pages = [
    HomePage(userHealthy: widget.userHealthy),
    // FoodCaloPage(),
    WalkingPage(),
    SettingPage(),
    ];
  }

  void _onItemTapped(int index) {

    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_outlined),
            label: 'Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Info',
          ),
        ],
      ),
    );
  }
}
