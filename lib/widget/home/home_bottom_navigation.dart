import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthylife/model/UserDetail.dart';
import 'package:healthylife/model/UserHealthy.dart';
import 'package:healthylife/page/bmi/bmi_page.dart';
import 'package:healthylife/page/calo/calo_page.dart';
import 'package:healthylife/page/fat/fat_page.dart';
import 'package:healthylife/page/home/home_page.dart';
import 'package:healthylife/page/food_calo/food_calo.dart';
import 'package:healthylife/page/setting/setting_page.dart';
import 'package:healthylife/page/walking/walking_page.dart';
import 'package:intl/intl.dart';

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


  void fetchData() async {
    _pages = [
    HomePage(userHealthy: widget.userHealthy),
    // FoodCaloPage(),
    WalkingPage(),
    SettingPage(),
    ];

    await getUserDetail(widget.userHealthy.UserID, DateTime.now());
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

  Future<void> getUserDetail(String userID, DateTime dateTime) async {
    try {
      String dateHistory = DateFormat('dd/MM/yyyy').format(dateTime);
      final userDetailCollection =
      FirebaseFirestore.instance.collection('UserDetail');

      final userDetailQuerySnapshot = await userDetailCollection
          .where('UserID', isEqualTo: userID)
          .where('DateHistory', isEqualTo: dateHistory)
          .get();

      // Check if data exists for the given date
      if (userDetailQuerySnapshot.docs.isEmpty) {
        // Start from the previous date
        DateTime previousDate = dateTime.subtract(Duration(days: 1));

        // Loop until data is found or a limit is reached
        int limit = 0; // Limit to 7 days ago
        while (limit < 7) {
          String previousDateHistory = DateFormat('dd/MM/yyyy').format(previousDate);

          final previousUserDetailQuerySnapshot = await userDetailCollection
              .where('UserID', isEqualTo: userID)
              .where('DateHistory', isEqualTo: previousDateHistory)
              .get();

          if (previousUserDetailQuerySnapshot.docs.isNotEmpty) {
            final uid = userDetailCollection.doc().id;

            final document = previousUserDetailQuerySnapshot.docs.first;

            UserDetail userDetail = UserDetail.fromFirestore(document);

            userDetail.UserDetailID = uid;
            userDetail.DateHistory = dateHistory;

                await userDetailCollection
                .doc(userDetail.UserDetailID)
                .set(userDetail.toJson())
                .then((value) {

            }).catchError((error) => print("Failed to get user detail: $error"));
                print('limít1: ${limit}');
            break; // Exit the loop since data is found
          }

          // Move to the previous day
          previousDate = previousDate.subtract(Duration(days: 1));
          limit++;
          print('limit2: ${limit}');
        }

        for(int i = 1; i <= limit; i++) {
          DateTime previousDate = dateTime.subtract(Duration(days: i));
          String previousDateHistory = DateFormat('dd/MM/yyyy').format(previousDate);

          final previousUserDetailQuerySnapshot = await userDetailCollection
              .where('UserID', isEqualTo: userID)
              .where('DateHistory', isEqualTo: dateHistory)
              .get();

          if (previousUserDetailQuerySnapshot.docs.isNotEmpty) {
            final uid = userDetailCollection.doc().id;

            final document = previousUserDetailQuerySnapshot.docs.first;

            UserDetail userDetail = UserDetail.fromFirestore(document);

            userDetail.UserDetailID = uid;
            userDetail.DateHistory = previousDateHistory;

            await userDetailCollection
                .doc(userDetail.UserDetailID)
                .set(userDetail.toJson())
                .then((value) {

            }).catchError((error) => print("Failed to get user detail: $error"));
          }
        }

        print(limit);

        if (limit == 0) {
          // Handle the case where no data is found within the limit
        }
      } else {
        // Data exists for the given date, handle accordingly
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
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
