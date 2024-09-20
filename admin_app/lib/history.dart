import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyHistory extends StatefulWidget {
  const MyHistory({super.key});

  @override
  _MyHistoryState createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  int _selectedIndex = 2; // Set default index to 2 for "History"

  // Dummy data for history
  final List<Map<String, String>> _historyData = [
    {'date': '2024-09-19', 'checkIn': '09:00 AM', 'checkOut': '05:00 PM'},
    {'date': '2024-09-18', 'checkIn': '08:45 AM', 'checkOut': '04:30 PM'},
    {'date': '2024-09-17', 'checkIn': '09:10 AM', 'checkOut': '05:15 PM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: const Color(0xFF6962AD),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: const Color(0xFF6962AD),
            color: const Color(0xFF000000),
            activeColor: const Color(0xFF000000),
            tabBackgroundColor: const Color(0xFF96E9C6),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'History',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF96E9C6),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _historyData.length,
                itemBuilder: (context, index) {
                  final history = _historyData[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Color(0xFF96E9C6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(15),
                      title: Text(
                        'Date: ${history['date']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6962AD),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            'Check-in: ${history['checkIn']}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Check-out: ${history['checkOut']}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ],
                      ),
                      leading: const Icon(
                        Icons.history,
                        size: 40,
                        color: Color(0xFF6962AD),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
