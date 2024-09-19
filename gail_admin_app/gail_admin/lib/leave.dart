import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class LeavePage extends StatefulWidget {
  final int index;

  const LeavePage(this.index, {super.key});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        tabBackgroundColor: const Color(0xFF8967b3),
        activeColor: const Color(0xFFE6D9A2),
        backgroundColor: const Color(0xFF8967b3),
        gap: 15,
        selectedIndex: 2, // Requests active
        onTabChange: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, 'map');
          } else if (index == 1) {
            Navigator.pushNamed(context, 'details');
          } else if (index == 2) {
            // Stay on Requests page
          } else if (index == 3) {
            Navigator.pushNamed(context, 'login');
          }
        },
        tabs: const [
          GButton(
            icon: Icons.map,
            text: 'Map',
          ),
          GButton(
            icon: Icons.person,
            text: 'Employees',
          ),
          GButton(
            icon: Icons.messenger_outlined,
            text: 'Requests',
          ),
          GButton(
            icon: Icons.logout_rounded,
            text: 'Log Out',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 4, // messages count
          itemBuilder: (context, index) {
            return Card(
              color: const Color(0xFFCB80AB),
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  'Leave request message ${index + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Time here',
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
