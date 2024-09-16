import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyCheckin extends StatefulWidget {
  const MyCheckin({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyCheckinState createState() => _MyCheckinState();
}

class _MyCheckinState extends State<MyCheckin> {
  TimeOfDay _enterTime = const TimeOfDay(hour: 8, minute: 00);
  TimeOfDay _exitTime = const TimeOfDay(hour: 10, minute: 30);
  int _selectedIndex = 1; // Set default index to 1 for the "Manual" page

  void _showEntryTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _enterTime = value!;
      });
    });
  }

  void _showExitTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _exitTime = value!;
      });
    });
  }

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
            selectedIndex: _selectedIndex, // Use the current active index
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
                _selectedIndex = index; // Update index on tab change
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                _enterTime.format(context).toString(),
                style: const TextStyle(
                  fontSize: 35,
                  color: Color(0xFFEDE885),
                  fontFamily: 'QuickSandBold',
                ),
              ),
              MaterialButton(
                onPressed: _showEntryTimePicker,
                color: const Color(0xFFEDE885),
                child: const Text(
                  'CHECK IN TIME',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'QuickSandBold',
                  ),
                ),
              ),
              const SizedBox(height: 200),
              Text(
                _exitTime.format(context).toString(),
                style: const TextStyle(
                  fontSize: 35,
                  color: Color(0xFFEDE885),
                  fontFamily: 'QuickSandBold',
                ),
              ),
              MaterialButton(
                onPressed: _showExitTimePicker,
                color: const Color(0xFFEDE885),
                child: const Text(
                  'CHECK OUT TIME',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'QuickSandBold',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
