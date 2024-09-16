import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyHistory extends StatefulWidget {
  const MyHistory({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHistoryState createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  int _selectedIndex = 2; // Set default index to 2 for "History"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: const Color(0xFF797E44),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: const Color(0xFF797E44),
            color: const Color(0xFFEDE885),
            activeColor: const Color(0xFFEDE885),
            tabBackgroundColor: const Color(0xFFA1A364),
            gap: 45,
            padding: const EdgeInsets.all(16),
            selectedIndex: _selectedIndex, // Set active index to 2
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'HOME',
              ),
              GButton(
                icon: Icons.watch_later,
                text: 'Manual',
              ),
              GButton(
                icon: Icons.history,
                text: 'History',
              ),
              GButton(
                icon: Icons.arrow_back_ios_new_rounded,
                text: 'Log Out',
              ),
            ],
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });

              if (index == 0) {
                Navigator.pushNamed(context, 'map');
              } else if (index == 1) {
                Navigator.pushNamed(context, 'checkin');
              } else if (index == 2) {
                Navigator.pushNamed(context, 'history');
              } else if (index == 3) {
                Navigator.pushNamed(context, 'login');
              }
            },
          ),
        ),
      ),
      body: const Center(
          child: Text(
        'History Page Content',
        style: TextStyle(
          fontSize: 35,
          color: Color(0xFFEDE885),
          fontFamily: 'QuickSandBold',
        ),
      )),
    );
  }
}
